# arenaShareSDK


集成友盟分享的SDK，目前仅支持微信及QQ两个平台

## 使用说明

### 1. 通过Pod安装

```
pod 'ArenaShareSDK'
```

### 2. 配置Info.plist 和 URL Scheme

- 在项目的`Info.plist`文件中添加白名单，具体操作请[戳这里](http://dev.umeng.com/social/ios/quick-integration)
- 在项目的`Info -> URL Types `里添加对应平台的`URL Scheme`，具体操作请[戳这里](http://dev.umeng.com/social/ios/quick-integration)


### 3. 引入资源文件

用`Finder`打开`ArenaShareSDK`，把`Libraries`文件夹下所有的`.a`文件以及`Resources`文件夹下所有的`.bundle`文件都添加到项目中，然后在项目的`Build Phases -> Copy Bundle Resources `中引入刚才所有的`.a`和`.bundle`


### 4. 友盟初始化设置

需要在Appdelegate.swift文件中的`didFinishLaunchingWithOptions`函数里调用以下代码，主要是对友盟进行初始化的设置

```
//集成友盟分享的一些配置信息 友盟的APPKEY 以及微信和QQ的Key
Share.configUSharePlatforms(with: "59ee97488f4a9d1b8a000010", //友盟AppKey
 andWXAppKey: "wx085a8685d1892707", //微信平台的AppKey
 andWXSecret: "0a6538a186d20bc2b8d155362b21c9c2",  //微信平台的Secret
 andQQAppKey: "",  //QQ平台的AppKey
 andRedirectURL: "" 
 )
```

同时在Appdelegate.swift文件中的`openUrl`函数里调用以下代码，主要是为了让友盟分享的回调能响应

```
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    return Share.applicationOpen(url)
}
```


### 5. 调用分享功能

- 分享网页链接

	```
	Share.share(data: [ "title":"分享的标题",  //必填
                    "content":"分享的内容",  //必填
                    "url":"https://www.baidu.com",  //必填
                    "image":"https://www.baidu.com/pic/login.png"] //选填
                    )
	```


- 分享本地图片

	```
	Share.shareImage(data: [ "filePath":"图片在本地的路径"] //必填
                    )
	```

