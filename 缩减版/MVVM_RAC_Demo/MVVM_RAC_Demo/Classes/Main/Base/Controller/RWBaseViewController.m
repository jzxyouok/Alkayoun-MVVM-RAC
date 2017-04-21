//
//  RWBaseViewController.m
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/17.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWBaseViewController.h"
#import "RWViewModel.h"

@interface RWBaseViewController ()

@property (nonatomic, strong, readwrite) RWViewModel *viewModel;

@end

@implementation RWBaseViewController

#pragma mark - lifeC
- (instancetype)initWithViewModel:(RWViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //每创建一个控制器，就监听网络，网络正常就请求数据
    [self bindViewModel];
}

-(void)bindViewModel
{
    //1.监听网络状
    [RACObserve(HT_APPDelegate, NetWorkStatus) subscribeNext:^(NSNumber *networkStatus) {
        if (networkStatus.integerValue == RealStatusNotReachable || networkStatus.integerValue == RealStatusUnknown) {
            //控制器的viewModel 执行网络命令 不请求数据
            [self.viewModel.requestDataCommand execute:@(RealStatusNotReachable)];
        }else{
            //控制器的viewModel对象执行 网络命令 请求数据
            [self.viewModel.requestDataCommand execute:@1];
        }
    }];
}

//视图将展示：根据viewModel中navBarStyleType来重新加载导航栏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBar.userInteractionEnabled = NO;
//    [self removeFakeNavBar];
//    if (self.viewModel.navBarStyleType == kNavBarStyleHidden) {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        //隐藏边线
//        
//        [self addFakeNavBar];
//    }
}
//视图展示：
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    self.navigationController.navigationBar.userInteractionEnabled = YES;
//    [self removeFakeNavBar];
}
//视图将移除
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self removeFakeNavBar];
//    if (self.viewModel.navBarStyleType == kNavBarStyleHidden) {
//        [self addFakeNavBar];
//        self.navigationController.navigationBar.barStyle = UINavigationBar.appearance.barStyle;
//        self.navigationController.navigationBar.translucent = YES;
//        [self.navigationController.navigationBar setBackgroundImage:[UINavigationBar.appearance backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
//        //展示边线
////        [self HT_showBottomLineInView:self.navigationController.navigationBar];
//    }
}
//视图移除
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [self removeFakeNavBar];
}

#pragma mark - method
//添加navBar
- (void)addFakeNavBar {
    
    if (self.viewModel.navBarStyleType == kNavBarStyleHidden) {
        [self.navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        [self RW_hideBottomLineInView:self.navBar];
        
    }else {
        [self.navBar setBackgroundImage:[UINavigationBar.appearance backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
//        [self RW_showBottomLineInView:self.navBar];
        
    }
}

//移除navBar
- (void)removeFakeNavBar {
    if (self.navBar.superview) {
        [self.navBar removeFromSuperview];
    }
}

#pragma mark - lazy
- (UINavigationBar *)navBar
{
    return HT_LAZY(_navBar, ({
        
        UINavigationBar *bar = [[UINavigationBar alloc] init];
        bar.barStyle = UINavigationBar.appearance.barStyle;
        bar.translucent = YES;
        [self.view addSubview:bar];
        [bar setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        bar;
    }));
}
@end
