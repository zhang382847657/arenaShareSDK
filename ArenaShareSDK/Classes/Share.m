//
//  Share.m
//  ArenaShareSDK
//
//  Created by 张琳 on 2017/10/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

#import "Share.h"
#import "UIViewController+CurrentViewController.h"

// U-Share核心SDK
#import <UMSocialCore/UMSocialCore.h>
// U-Share分享面板SDK，未添加分享面板SDK可将此行去掉
#import <UShareUI/UShareUI.h>

@implementation Share


/** 分享成功失败的回调
 * 请在appdelegate里面的 openUrl 中加入此方法
 */
+(BOOL)applicationOpen:(NSURL*) url{
    return [[UMSocialManager defaultManager] handleOpenURL:url];
}


//友盟基本设置
+ (void)configUSharePlatformsWith:(NSString *)umAppKey andWXAppKey:(NSString *)wxAppKey
                      andWXSecret:(NSString *)wxSecret andQQAppKey:(NSString *)qqAppKey
                   andRedirectURL:(NSString *)redirectUrl{
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:umAppKey];
    
    
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:wxAppKey appSecret:wxSecret redirectURL:nil];
    
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:qqAppKey/*设置QQ平台的appID*/  appSecret:nil redirectURL:redirectUrl];
}

//分享网页链接
+(void)share:(NSDictionary*) data{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建网页内容对象
        NSString* thumbURL =  data[@"image"];
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:data[@"title"] descr:data[@"content"] thumImage:thumbURL];
        //设置网页地址
        shareObject.webpageUrl = data[@"url"];
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[UIViewController currentViewController:nil] completion:^(id shareData, NSError *error) {
            
            NSMutableDictionary *result = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"success",@"result", nil] ;
            
            
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
                result = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"failed",@"result",error.description,@"data", nil] ;
            }else{
                if ([shareData isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = shareData;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",shareData);
                }
                
                [result setObject:@"分享成功" forKey:@"data"];
                
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:data[@"callback"] object:result userInfo:nil];
            
        }];
        
    }];
}


//分享本地图片
+(void)shareImage:(NSDictionary*) data{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        [shareObject setShareImage:[UIImage imageWithContentsOfFile:data[@"filePath"]]];
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[UIViewController currentViewController:nil] completion:^(id shareData, NSError *error) {
            
            NSMutableDictionary *result = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"success",@"result", nil] ;
            
            
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
                result = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"failed",@"result",error.description,@"data", nil] ;
            }else{
                if ([shareData isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = shareData;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                }else{
                    UMSocialLogInfo(@"response data is %@",shareData);
                }
                
                [result setObject:@"分享成功" forKey:@"data"];
                
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:data[@"callback"] object:result userInfo:nil];
            
        }];
        
    }];
}

@end

