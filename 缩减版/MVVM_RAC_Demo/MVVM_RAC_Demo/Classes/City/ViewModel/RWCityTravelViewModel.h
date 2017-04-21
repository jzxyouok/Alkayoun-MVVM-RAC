//
//  RWCityTravelViewModel.h
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWViewModel.h"

@interface RWCityTravelViewModel : RWViewModel

/**
 *  错误信号
 */
@property (strong, nonatomic) RACSignal *travelConnectionErrors;
/**
 *  更多数据请求
 */
@property (strong, nonatomic) RACCommand *travelMoreDataCommand;
/**
 *  更多错误信号
 */
@property (strong, nonatomic) RACSignal *travelMoreConnectionErrors;
/**
 *  导航栏rightBar
 */
@property (strong, nonatomic) RACCommand *rightBarButtonItemCommand;
/**
 *  游记详情
 */
@property (strong, nonatomic) RACCommand *travelDetailCommand;
/**
 *  游记数据
 */
@property (strong, nonatomic) NSArray *travelData;
/**
 *  banner数据
 */
@property (strong, nonatomic) NSArray *bannerData;
/**
 *  是否为搜索
 */
@property (assign , nonatomic) BOOL  isSearch;

@end
