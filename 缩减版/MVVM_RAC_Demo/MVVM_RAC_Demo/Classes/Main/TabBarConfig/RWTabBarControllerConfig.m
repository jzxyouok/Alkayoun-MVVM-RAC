//
//  RWTabBarControllerConfig.m
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/17.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWTabBarControllerConfig.h"
#import "RWViewModelServicesImpl.h"
#import "RWCityTraveProtocolImpl.h"
#import "RWCityTravelViewModel.h"
#import "RWCityTravelNotesController.h"
#import "RWConfigBaseNavigationController.h"

@interface RWTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) RWCustomTabBarController *tabBarController;

//数据服务
@property (nonatomic, strong) RWViewModelServicesImpl  *viewModelService;
//首页ViewModel
@property (nonatomic, strong) RWCityTravelViewModel *cityTravelViewModel;
//发现ViewModel

@end
@implementation RWTabBarControllerConfig

//懒加载tabBarController
-(RWCustomTabBarController *)tabBarController
{
    return HT_LAZY(_tabBarController, ({
    
        RWCustomTabBarController *tabBarController = [RWCustomTabBarController tabBarControllerWithViewControllers:self.viewControllersForController tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        
        //tabBarItem 的选中和不选中文字和背景图片属性
        [self customizeTabBarAppearance:tabBarController];
        
        tabBarController;
    
    }));
}


- (NSArray *)viewControllersForController{
    // 数据服务
    self.viewModelService = [[RWViewModelServicesImpl alloc] initModelServiceImpl];
    
    //首页
    self.cityTravelViewModel = [[RWCityTravelViewModel alloc]initWithServices:self.viewModelService params:nil];
    RWCityTravelNotesController *firstViewController = [[RWCityTravelNotesController alloc]initWithViewModel:self.cityTravelViewModel];
    RWConfigBaseNavigationController *firstNavtionController = [[RWConfigBaseNavigationController alloc]initWithRootViewController:firstViewController];
    //发现
    UIViewController *secondViewController = [[UIViewController alloc]init];
    RWConfigBaseNavigationController *secondNavtionController = [[RWConfigBaseNavigationController alloc]initWithRootViewController:secondViewController];
    
    //目的地
    UIViewController *destinationViewController = [[UIViewController alloc]init];
    RWConfigBaseNavigationController *thirdNavtionController = [[RWConfigBaseNavigationController alloc]initWithRootViewController:destinationViewController];
    
    //我的
    UIViewController *meViewController = [[UIViewController alloc]init];
    RWConfigBaseNavigationController *foruNavigationController = [[RWConfigBaseNavigationController alloc]initWithRootViewController:meViewController];
    
    
    NSArray *viewControllers = @[
                                 firstNavtionController,
                                 secondNavtionController,
                                 thirdNavtionController,
                                 foruNavigationController
                                 ];
    return viewControllers;
}

//设置tabBarItem的属性
- (NSArray *)tabBarItemsAttributesForController{
    NSDictionary *dict1 = @{
                            HTTabBarItemTitle : @"城市游",
                            HTTabBarItemImage : @"root_tab_recommand_25x25_",
                            HTTabBarItemSelectedImage : @"root_tab_recommand_hl_25x25_",
                            };
    NSDictionary *dict2 = @{
                            HTTabBarItemTitle : @"发现",
                            HTTabBarItemImage : @"root_tab_discover_25x25_",
                            HTTabBarItemSelectedImage : @"root_tab_discover_hl_25x25_",
                            };
    NSDictionary *dict3 = @{
                            HTTabBarItemTitle : @"目的地",
                            HTTabBarItemImage : @"root_tab_msg_25x25_",
                            HTTabBarItemSelectedImage : @"root_tab_msg_hl_25x25_",
                            };
    NSDictionary *dict4 = @{
                            HTTabBarItemTitle : @"我的",
                            HTTabBarItemImage : @"root_tab_me_25x25_",
                            HTTabBarItemSelectedImage : @"root_tab_me_hl_25x25_",
                            };
    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
                                       dict3,
                                       dict4
                                       ];
    return tabBarItemsAttributes;

}
/**
 *  tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性的设置
 */
- (void)customizeTabBarAppearance:(RWCustomTabBarController *)tabBarController {
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = SetColor(74, 189, 204);
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
}
@end
