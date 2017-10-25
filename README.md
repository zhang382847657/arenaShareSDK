# arenaShareSDK
集成友盟分享的SDK

## 使用说明

### 第一步：友盟初始化设置

需要在Appdelegate.swift文件中的didFinishLaunchingWithOptions函数里调用以下代码，主要是对友盟进行初始化的设置

**代码**
```
Share.configUSharePlatforms()
```


### 第二步：调用分享功能

*此功能可以在当前页面弹出分享弹窗，以及把想要分享的内容分享出去*

**代码**
```
Share.share(data: ["title":"分享的标题",
"content":"分享的内容",
"url":"https://www.baidu.com",
"imageUrl":"https://www.baidu.com/pic/login.png"])
```
**参数**
> data 字典类型
>   - title 分享的标题 必填
>   - content 分享的内容  必填
>   - url 分享的链接  必填
>   - imageUrl 分享的图片  选填
