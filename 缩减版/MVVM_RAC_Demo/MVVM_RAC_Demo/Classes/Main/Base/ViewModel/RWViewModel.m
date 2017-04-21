//
//  RWViewModel.m
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/17.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWViewModel.h"
@interface RWViewModel ()

@property (nonatomic, strong, readwrite) id<RWViewModelService> services; //服务

@property (nonatomic, strong, readwrite) RACCommand *requestDataCommand;

@property (nonatomic, assign, readwrite)RWNavBarStyleType navBarStyleType; //导航样式

@property (nonatomic, readwrite, copy) NSString *title; //

@end
@implementation RWViewModel

//创建请求数据命令，命令执行后开始请求数据
-(instancetype)initWithServices:(id<RWViewModelService>)services params:(NSDictionary *)params
{
    if ([super init]) {
        
        self.services = services;
        self.navBarStyleType = [params[NavBarStyleTypekey] integerValue];
        self.title = params[ViewTitlekey];
        //命令创建
        @weakify(self);
        self.requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            @strongify(self)
            return [[self executeRequestDataSignal:input] takeUntil:self.rac_willDeallocSignal];
            
        }];
        
        [self initialize];
    }
    return self;
}


- (void)initialize{
    //此方法是给子类重写的，调用子类方法
}

- (RACSignal *)executeRequestDataSignal:(id)input
{
    //此方法是给子类重写的，调用子类方法
    return [RACSignal empty];
}


@end
