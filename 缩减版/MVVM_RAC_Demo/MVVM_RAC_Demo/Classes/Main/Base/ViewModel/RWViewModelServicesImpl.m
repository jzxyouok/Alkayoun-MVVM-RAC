//
//  RWViewModelServicesImpl.m
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWViewModelServicesImpl.h"
#import "RWCityTraveProtocolImpl.h"
@interface RWViewModelServicesImpl ()

//首页数据服务
@property (nonatomic, strong)RWCityTraveProtocolImpl *cityTravelService;

///**
// *  发现数据服务
// */
//@property (strong, nonatomic) RWFindProtocolImpl *findService;
///**
// *  探索视频服务
// */
//@property (strong, nonatomic) HTExploreMoreImpl *exploreService;
///**
// *  web服务
// */
//@property (strong, nonatomic) HTWebProtocolImpl *wedService;

@end
@implementation RWViewModelServicesImpl
- (instancetype)initModelServiceImpl
{
    if (self = [super init]) {
        _cityTravelService = [RWCityTraveProtocolImpl new];
    }
    return self;
}

- (id<RWViewModelProtocolImpl>)getCityTravelService
{
    NSLog(@"______HTExploreMoreImpl____使用代理方法，返回“首页数据服务”_______");
    return self.cityTravelService;
}
- (id<RWViewModelProtocolImpl>)getFindService
{
    return nil;
}
- (id<RWViewModelProtocolImpl>)getExploreMoreService
{
    return nil;
}
- (id<RWViewModelProtocolImpl>)getWebService
{
    return nil;
}
@end
