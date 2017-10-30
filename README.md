# arenaShareSDK
集成友盟分享的SDK

## 使用说明

### 第一步：友盟初始化设置

需要在Appdelegate.swift文件中的didFinishLaunchingWithOptions函数里调用以下代码，主要是对友盟进行初始化的设置

**代码**
```
///集成友盟分享的一些配置信息 友盟的APPKEY 以及微信和QQ的Key///
Share.configUSharePlatforms(with: "59ee97488f4a9d1b8a000010", andWXAppKey: "wx085a8685d1892707", andWXSecret: "0a6538a186d20bc2b8d155362b21c9c2", andQQAppKey: "", andRedirectURL: "")
```


### 第二步：调用分享功能

*此功能可以在当前页面弹出分享弹窗，以及把想要分享的内容分享出去*

**代码**
```
Share.share(data: [ "title":"分享的标题",
                    "content":"分享的内容",
                    "url":"https://www.baidu.com",
                    "image":"https://www.baidu.com/pic/login.png"])
```
**参数**
> data 字典类型
>   - title 分享的标题 必填
>   - content 分享的内容  必填
>   - url 分享的链接  必填
>   - image 分享的图片  选填
