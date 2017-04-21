//
//  RWViewModel.h
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/17.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import <Foundation/Foundation.h>
#import "RWViewModelService.h"

typedef NS_ENUM(NSUInteger, RWNavBarStyleType) {
    kNavBarStyleNomal = 0, //默认
    kNavBarStyleHidden = 1,  //隐藏
};

@interface RWViewModel : NSObject

//数据请求
@property (strong, nonatomic, readonly) RACCommand *requestDataCommand;

//网络状态
@property (assign, nonatomic) ReachabilityStatus netWorkStatus;

//NavBar类型
@property (nonatomic, assign, readonly) RWNavBarStyleType navBarStyleType;

//标题
@property (nonatomic, readonly, copy) NSString *title;

//viewModel 服务
@property (nonatomic, strong, readonly) id<RWViewModelService> services;


- (instancetype)initWithServices:(id<RWViewModelService>)services params:(NSDictionary *)params;

- (void)initialize;

- (RACSignal *)executeRequestDataSignal:(id)input;

@end
