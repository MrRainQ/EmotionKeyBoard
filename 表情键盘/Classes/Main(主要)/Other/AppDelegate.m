//
//  AppDelegate.m
//   
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年  . All rights reserved.
//

#import "AppDelegate.h"

#import "HMMMMViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2.显示窗口(成为主窗口)
    [self.window makeKeyAndVisible];
    
    // 3.设置窗口的根控制器
    HMMMMViewController *hmm = [[HMMMMViewController alloc]init];
    
    self.window.rootViewController = hmm;

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/**
 *  程序进入后台的时候调用
 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // 提醒操作系统：当前这个应用程序需要在后台开启一个任务
    // 操作系统会允许这个应用程序在后台保持运行状态（能够持续的时间是不确定）
    UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
        // 后台运行的时间到期了，就会自动调用这个block
        [application endBackgroundTask:taskID];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//
//- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
//{
//    // 赶紧清除所有的内存缓存
//    [[SDImageCache sharedImageCache] clearMemory];
//    
//    // 赶紧停止正在进行的图片下载操作
//    [[SDWebImageManager sharedManager] cancelAll];
//}

@end
