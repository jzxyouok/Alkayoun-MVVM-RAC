//
//  AppDelegate.m
//  MVVM_RAC_Demo
//
//  Created by fdiosone on 2017/4/19.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import "RWTabBarControllerConfig.h"
#import "RWServerConfig.h"
#import <IQKeyboardManager.h>
#import "HTLBSManager.h"
@interface AppDelegate ()<HTLBSManagerDelegate>
@property (nonatomic, strong)HTLBSManager *lbs;
@property (nonatomic, assign, readwrite) ReachabilityStatus NetWorkStatus;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置根控制器
    [self setRootController];
    //设置服务器环境： 01：生产环境 00：测试环境
    [RWServerConfig setRWConfigEnv:@"01"];
    // 配置IQKeyboardManager
    [self configurationIQKeyboard];
    // 获取定位信息
    self.lbs = [HTLBSManager startGetLBSWithDelegate:self];
    // 配置网络状态
    [self configurationNetWorkStatus];
    return YES;
}

//设置根控制器
- (void)setRootController
{
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    RWTabBarControllerConfig *tabBarControllerConfig = [[RWTabBarControllerConfig alloc]init];
    [self.window setRootViewController:tabBarControllerConfig.tabBarController];
    
    [self.window makeKeyAndVisible];
    
}

//配置IQKeyBoard
- (void)configurationIQKeyboard
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES; //显示键盘上面的tool条
}

//配置网络
- (void)configurationNetWorkStatus
{
    
    [GLobalRealReachability startNotifier];
    
    RAC(self, NetWorkStatus) = [[[[[NSNotificationCenter defaultCenter]
                                   rac_addObserverForName:kRealReachabilityChangedNotification object:nil]
                                  map:^(NSNotification *notification) {
                                      return @([notification.object currentReachabilityStatus]);
                                  }]
                                 startWith:@([GLobalRealReachability currentReachabilityStatus])]
                                distinctUntilChanged];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
