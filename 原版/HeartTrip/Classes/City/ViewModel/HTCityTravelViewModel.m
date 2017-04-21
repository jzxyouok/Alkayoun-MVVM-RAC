//
//  HTCityTravelViewModel.m
//  HeartTrip
//
//  Created by 熊彬 on 16/11/16.
//  Copyright © 2016年 BinBear. All rights reserved.
//

#import "HTCityTravelViewModel.h"
#import "HTBannerModel.h"
#import "HTCityTravelItemModel.h"
#import "HTMediatorAction+HTCityTravelDetailController.h"
#import "HTViewModelServicesImpl.h"
#import "HTCityTravelDetialViewModel.h"

@interface HTCityTravelViewModel ()

@end

@implementation HTCityTravelViewModel
- (instancetype)initWithServices:(id<HTViewModelService>)services params:(NSDictionary *)params
{
    if (self = [super initWithServices:services params:params]) {
        
        _travelData = [NSArray new];
        _bannerData = [NSArray new];
        _isSearch = NO;
    }
    return self;
}
- (void)initialize
{
    [super initialize];
    
    RACSignal *visibleStateChanged = [RACObserve(self, isSearch) skip:1];
    

    [visibleStateChanged subscribeNext:^(NSNumber *visible) {
        NSLog(@"______HTCityTravelViewModel的isSearch属性值发生变化_____发送信号___%@",visible);
        _isSearch = visible.boolValue;
    }];
    
    _travelMoreDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"_______HTCityTravelViewModel开始执行更多请求的命令_____%@",input);
        return [[[self.services getCityTravelService] requestCityTravelMoreDataSignal:CityTravel_URL] doNext:^(id  _Nullable result) {
            NSLog(@"_____HTCityTravelViewModel___Signal doNext方法_____信号触发在未达到订阅者前执行block_____%@",result);
            self.travelData = result[TravelDatakey];
            
        }];
    }];
    
    _rightBarButtonItemCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"_______HTCityTravelViewModel开始执行导航栏右侧按钮的命令_____%@",input);
        return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"____HTCityTravelViewModel____右侧按钮命令信号block_______");
            [subscriber sendNext:[NSNumber numberWithBool:self.isSearch]];
            NSLog(@"____HTCityTravelViewModel____右侧按钮命令信号block_____开始发送信号__");
            [subscriber sendCompleted];
            NSLog(@"____HTCityTravelViewModel____右侧按钮命令信号block_____信号完成__");
            return nil;
        }];
    }];
    
    _travelDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        HTViewModelServicesImpl *servicesImpl = [[HTViewModelServicesImpl alloc] initModelServiceImpl];
        HTCityTravelDetialViewModel *viewModel = [[HTCityTravelDetialViewModel alloc] initWithServices:servicesImpl params:nil];
        [[HTMediatorAction sharedInstance] pushCityTravelDetailControllerWithViewModel:viewModel];
        
        return [RACSignal empty];
    }];
    
    _travelMoreConnectionErrors = _travelMoreDataCommand.errors;
}
- (RACSignal *)executeRequestDataSignal:(id)input
{
    NSLog(@"______HTCityTravelViewModel____重写父类方法executeRequestDataSignal___%@",input);
    if ([input integerValue] == RealStatusNotReachable) {
        NSLog(@"______HTCityTravelViewModel____重写父类方法executeRequestDataSignal___如果参数等于0则赋值到self.网络状态 ，返回空信号");
        self.netWorkStatus = RealStatusNotReachable;
        return [RACSignal empty];
        
    }else{
        NSLog(@"______HTCityTravelViewModel____重写父类方法executeRequestDataSignal___如果参数不等于0则拿到self.services数组，执行getCityTravelService方法，获得首页数据服务，执行requestCityTravelDataSignal方法参数url，返回值是RAC信号，使用doNext方法，在信号达到订阅者前执行block");
        return [[[self.services getCityTravelService] requestCityTravelDataSignal:CityTravel_URL] doNext:^(id  _Nullable result) {
            NSLog(@"______HTCityTravelViewModel____网络检测畅通___next方法block中赋值数据————%@",result);
            self.bannerData = result[BannerDatakey];
            self.travelData = result[TravelDatakey];
            
        }];
    }
}
@end
