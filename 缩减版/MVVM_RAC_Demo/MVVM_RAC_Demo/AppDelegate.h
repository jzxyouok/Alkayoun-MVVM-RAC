//
//  AppDelegate.h
//  MVVM_RAC_Demo
//
//  Created by fdiosone on 2017/4/19.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RealReachability.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

///网络状态
@property (nonatomic, assign , readonly) ReachabilityStatus NetWorkStatus;


@end

