//
//  AppDelegate.m
//  QYJumpToMyView
//
//  Created by qianye on 15/8/14.
//  Copyright (c) 2015年 qianye. All rights reserved.
//

#import "AppDelegate.h"

#import "MyViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        if ([application currentUserNotificationSettings].types == UIUserNotificationTypeNone) {
            UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
            [application registerUserNotificationSettings:notificationSettings];
        }else {
            [application registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                             UIUserNotificationTypeSound |
                                                             UIUserNotificationTypeAlert)];
        }
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNotification.alertAction = @"本地通知";
    localNotification.alertBody = @"点击打开MyViewController";
    localNotification.applicationIconBadgeNumber = 1;
    [application scheduleLocalNotification:localNotification];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    /*
     host;
     port;
     user;
     password;
     path;
     fragment;
     parameterString;
     query;
     relativePath;
     */
    NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL query: %@", [url query]);
    NSLog(@"URL host: %@", [url host]);
    NSLog(@"URL port: %@", [url port]);
    NSLog(@"URL user: %@", [url user]);
    NSLog(@"URL password: %@", [url password]);
    NSLog(@"URL path: %@", [url path]);
    NSLog(@"URL fragment: %@", [url fragment]);
    NSLog(@"URL parameterString: %@", [url parameterString]);
    NSLog(@"URL relativePath: %@", [url relativePath]);
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *myNC = [mainStory instantiateViewControllerWithIdentifier:@"MyView"];
    [self.window.rootViewController presentViewController:myNC  animated:YES completion:nil];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
