//
//  Share.h
//  ArenaShareSDK
//
//  Created by 张琳 on 2017/10/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Share : NSObject

/** 分享成功失败的回调
 * 请在appdelegate里面的 openUrl 中加入此方法
 */
+(BOOL)applicationOpen:(NSURL*) url;

//友盟基本设置
+ (void)configUSharePlatformsWith:(NSString *)umAppKey andWXAppKey:(NSString *)wxAppKey
                      andWXSecret:(NSString *)wxSecret andQQAppKey:(NSString *)qqAppKey
                   andRedirectURL:(NSString *)redirectUrl;
/** 分享网页
 *  标题、描述、缩略图、网页url
 */
+(void)share:(NSDictionary*) data;

/** 分享本地图片*/
+(void)shareImage:(NSDictionary*) data;

@end

