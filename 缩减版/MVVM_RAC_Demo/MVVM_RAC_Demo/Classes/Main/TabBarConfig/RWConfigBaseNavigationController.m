//
//  RWConfigBaseNavigationController.m
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWConfigBaseNavigationController.h"
#import "UIBarButtonItem+HTBarButtonCustom.h"
@interface RWConfigBaseNavigationController ()

@end

@implementation RWConfigBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self setUpNavigationBarAppearace];
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = CGRectGetWidth([UIScreen mainScreen].bounds)/3; //全局手势返回
        [self setUpCustomNavigationbarwithController:viewController];
    }
    [super pushViewController:viewController animated:YES];
}



#pragma mark - 全局导航属性
- (void)setUpNavigationBarAppearace
{
    UINavigationBar *navigationBarAppearace = [UINavigationBar appearance];
    
    NSDictionary *textAttributes = @{NSFontAttributeName:HTSetFont(@"Noteworthy-Bold", 18),NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [navigationBarAppearace setTitleTextAttributes:textAttributes];
    navigationBarAppearace.tintColor = [UIColor whiteColor];
    navigationBarAppearace.barTintColor = SetColor(80, 189, 203);
}

- (void)setUpCustomNavigationbarwithController:(UIViewController *)viewController
{
    UIBarButtonItem *item = [UIBarButtonItem itemWithTarget:self action:@selector(btnLeftBtn) image:@"icon_nav_back_white_19x18_"  selectImage:@"icon_nav_back_white_19x18_"];
    
    viewController.navigationItem.leftBarButtonItem = item;
    
}

#pragma mark - btn
- (void)btnLeftBtn
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIStatusBar
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
