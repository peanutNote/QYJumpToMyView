## QYJumpToMyView
* Click on the notification bar or click on a link to the application to jump to the specified page 
* 点击通知栏或者点击一个链接让应用跳转到指定的页面

## 问题产生原因
* 其实之前在做蓝犀牛客户端的时候就有这种需求，但由于该需求并不是必须，同时自己在一番尝试以后也并没有找到一个比较好的解决办法就暂时搁下了
* 此次做蓝犀牛司机端再次遇到该需求，于是就花了点时间多尝试了几次（可能是没怎么在网上，目前搜索的过程中并没有遇到有人提及这类问题的解决，没办法只能自己去尝试了），终于让我找到一个比较好的方式而且感觉目前别人实现的方式也是如此。

## 遇到的问题
* 因为app在后台运行点击通知栏或者点击某个网址的时候打开应用在AppDelegate中会调用相应的方法，当时我就想可不可以在该方法中创建需要跳转的师徒控制器并将其设置为window的rootViewController，然后将他的导航栏返回方法中重新将之前的rootViewController设置回来。尝试以后问题来了，一两次或许还好如果多次打开，因为在重新设置rootViewController的过程中之前设置的控制器并没有被释放掉，而且如果要在打开的页面有push操作那么后面的页面的导航栏返回方法都得增加一个重新设置rootViewController的代码
* 第二个想法在AppDelegate相应方法中获取当前正在显示的导航栏控制器（由于每个标签栏都有且仅有一个导航栏控制器），然后再调用导航栏的pushViewController方法，尝试后发现该push方法会被执行但是没有进行视图切换

## 问题解决
>如果push不行那么模态视图呢，将需要跳转的视图用作模态视图弹出，同时结合模态视图的特点，在该导航内的任意一个视图控制中调用dismissViewControllerAnimated都可以回到上一个导航模态视图

## Demo说明
>在app进入后台的时候的开启了一个本地5秒后会执行的本地通知,点击通知会跳转到MyViewController，要想点击链接打开app需要在info中加入一下代码
```objc
<key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLName</key>
            <string>com.qianye.QYJumpToMyView</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>QYJumpToMyView</string>
            </array>
        </dict>
    </array>	
```
其中的QYJumpToMyView为项目的名字,做法类似  
本地通知回调方：
```objc
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
```  
点击链接回调方法：
```objc
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
```
