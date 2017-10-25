//
//  Share.swift
//  ArenaShareSDK
//
//  Created by 张琳 on 2017/10/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

import Foundation

public class Share: NSObject {
    
    //友盟基本设置
    public class func configUSharePlatforms(){
        
        /* 打开调试日志 */
        UMSocialManager.default().openLog(true)
        
        /* 设置友盟appkey */
        UMSocialManager.default().umSocialAppkey = "59ee97488f4a9d1b8a000010"
        
        
        /*
         设置微信的appKey和appSecret
         [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
         */
        UMSocialManager.default().setPlaform(.wechatSession, appKey: "", appSecret: "", redirectURL: nil)
        
        /* 设置分享到QQ互联的appID
         * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
         100424468.no permission of union id
         [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
         */
        UMSocialManager.default().setPlaform(.QQ, appKey: "1105821097" /*设置QQ平台的appID*/, appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
        
        
    }
    
    //MARK: 弹出分享面板
    public class func showShareMenuViewInWindowWithPlatformSelectionBlock(selectionBlock:@escaping (_ platformType:UMSocialPlatformType, _ userinfo:Any?) -> Void) -> Void {
        
        //友盟分享面板显示的分享平台
        UMSocialUIManager.setPreDefinePlatforms([UMSocialPlatformType.wechatSession,UMSocialPlatformType.wechatTimeLine,UMSocialPlatformType.QQ])
        
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userinfo) in
            selectionBlock(platformType,userinfo);
        }
    }
    
    //MARK: 分享
    public class func share(data: [String: Any]){
        
        //此时data里面一定要有（title、content、url），其中imageUrl可选
        
        //创建分享消息对象
        let messageObject = UMSocialMessageObject()
        //创建网页内容对象
        let shareObject = UMShareWebpageObject.shareObject(withTitle: data["title"] as! String, descr: data["content"] as! String, thumImage: data["imageUrl"] as? String)
        //设置网页地址
        shareObject?.webpageUrl = data["url"] as! String
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //打开分享的界面
        self.showShareMenuViewInWindowWithPlatformSelectionBlock { (platformType, userinfo) in
            
            //调用分享
            UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: UIViewController.currentViewController()) { (shareResponse, error) in
                
                var result = ["result": "success"]
        
                if error != nil {
                    result = ["result": "failed"]
                }else{
                    
                    if shareResponse is UMSocialShareResponse {
                        
                        let resp:UMSocialShareResponse = shareResponse as! UMSocialShareResponse
                        //分享结果消息
                        result["message"] = resp.message
                        //第三方原始返回的数据
                        result["originalResponse"] = resp.originalResponse as? String
                        
                    }else{
                        result["data"] = shareResponse as? String
                    }
                    
                }
                
                NotificationCenter.default.post(name:NSNotification.Name(rawValue: data["callback"] as! String), object: result, userInfo: nil)
                
            }
            
        }
        
        
    }
    
    //MARK: 授权
    public class func auth(plattype:UMSocialPlatformType,
                           viewController:UIViewController?,
                           completion: @escaping (_ data:Any?,_ error:Error?) -> Void) -> Void{
        UMSocialManager.default().auth(with: plattype, currentViewController: viewController) { (shareResponse, error) in
            completion(shareResponse, error);
        }
    }
    
    //MARK: 取消授权
    public class func cancelAuth(plattype:UMSocialPlatformType,
                                 completion: @escaping (_ data:Any?,_ error:Error?) -> Void) -> Void{
        UMSocialManager.default().cancelAuth(with: plattype) { (shareResponse, error) in
            completion(shareResponse, error);
        }
    }
    
    //MARK: 获得用户资料
    public class func getUserInfo(plattype:UMSocialPlatformType,
                                  viewController:UIViewController?,
                                  completion: @escaping (_ data:Any?,_ error:Error?) -> Void) -> Void{
        UMSocialManager.default().getUserInfo(with: plattype, currentViewController: viewController) { (shareResponse, error) in
            completion(shareResponse, error);
        }
    }
    
    
}


