//
//  RWBaseViewController.h
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/17.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import <UIKit/UIKit.h>

@class RWViewModel;

@interface RWBaseViewController : UIViewController

//viewModel
@property (nonatomic, strong, readonly) RWViewModel *viewModel;

//navBar
@property (nonatomic, strong)UINavigationBar *navBar;

//创建对象 赋值viewModel
- (instancetype)initWithViewModel:(RWViewModel *)viewModel;

//创建连接
- (void)bindViewModel;

@end
