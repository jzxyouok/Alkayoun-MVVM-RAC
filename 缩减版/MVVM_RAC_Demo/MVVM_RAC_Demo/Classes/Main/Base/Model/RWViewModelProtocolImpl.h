//
//  RWViewModelProtocolImpl.h
//  MVVM+RAC_Demo
//
//  Created by fdiosone on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RWViewModelProtocolImpl <NSObject>

//model 需要实现的数据请求方法
@optional
// 加载首页数据
- (RACSignal *)requestCityTravelDataSignal:(NSString *)requestUrl;

// 加载首页更多数据
- (RACSignal *)requestCityTravelMoreDataSignal:(NSString *)requestUrl;

// 加载发现数据
- (RACSignal *)requestFindDataSignal:(NSString *)requestUrl;

// 加载发现更多数据
- (RACSignal *)requestFindMoreDataSignal:(NSString *)requestUrl;

// 加载探索视频数据
- (RACSignal *)requestExploreVideosDataSignal:(NSString *)requestUrl;

// 加载探索视频更多数据
- (RACSignal *)requestExploreVideosMoreDataSignal:(NSString *)requestUrl;

@end
