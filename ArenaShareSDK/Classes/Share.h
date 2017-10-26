//
//  Share.h
//  ArenaShareSDK
//
//  Created by 张琳 on 2017/10/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Share : NSObject

//友盟基本设置
+ (void)configUSharePlatformsWith:(NSString *)umAppKey andWXAppKey:(NSString *)wxAppKey
                      andWXSecret:(NSString *)wxSecret andQQAppKey:(NSString *)qqAppKey
                   andRedirectURL:(NSString *)redirectUrl;
//分享
+(void)share:(NSDictionary*) data;
@end
