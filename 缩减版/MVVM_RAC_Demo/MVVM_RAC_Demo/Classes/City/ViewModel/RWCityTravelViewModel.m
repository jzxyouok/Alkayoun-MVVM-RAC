//
//  RWCityTravelViewModel.m
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWCityTravelViewModel.h"

@interface RWCityTravelViewModel ()

@end

@implementation RWCityTravelViewModel

- (instancetype)initWithServices:(id<RWViewModelService>)services params:(NSDictionary *)params
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
    
    //创建对应搜索 的监听信号
    RACSignal *visibleStateChanged = [RACObserve(self, isSearch) skip:1];
    
    //订阅信号
    [visibleStateChanged subscribeNext:^(NSNumber *visible) {
        _isSearch = visible.boolValue;
    }];
    
    //发现更多  创建命令
    _travelMoreDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [[[self.services getCityTravelService] requestCityTravelMoreDataSignal:CityTravel_URL] doNext:^(id  _Nullable result) {
            self.travelData = result[TravelDatakey]; //热门游记数据
        }];
        
    }];
    
    //搜索按钮 创建命令
    _rightBarButtonItemCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:[NSNumber numberWithBool:self.isSearch]];//发送信号
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    
    //
   _travelMoreConnectionErrors = _travelMoreDataCommand.errors;

}

-(RACSignal *)executeRequestDataSignal:(id)input
{
    if ([input integerValue] == RealStatusNotReachable) {
        //无网络状态
        self.netWorkStatus = RealStatusNotReachable;
        return [RACSignal empty];
        
    }else{
        //有网络状态： 创建数据model，准备接收数据。 model信号 开始请求数据，通过url。 在数据被订阅者接收前，存储数据模型数组。
        return [[[self.services getCityTravelService] requestCityTravelDataSignal:CityTravel_URL] doNext:^(id  _Nullable result) {
            self.bannerData = result[BannerDatakey];
            self.travelData = result[TravelDatakey];
            
        }];
    }

}
@end
