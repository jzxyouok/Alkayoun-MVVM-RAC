//
//  RWConst.h
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/17.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RWConst : NSObject
/********** Project Key ***********/

// 首页banner数据key
FOUNDATION_EXTERN NSString *const BannerDatakey;
// 首页热门游记数据key
FOUNDATION_EXTERN NSString *const TravelDatakey;
// 发现视频数据key
FOUNDATION_EXTERN NSString *const FindVideoDatakey;
// 发现feed数据key
FOUNDATION_EXTERN NSString *const FindFeedDatakey;
// 经度key
FOUNDATION_EXTERN NSString *const Longitudekey;
// 纬度key
FOUNDATION_EXTERN NSString *const Latitudekey;
// 城市名key
FOUNDATION_EXTERN NSString *const CityNamekey;
// 网页标题key
FOUNDATION_EXTERN NSString *const ViewTitlekey;
// 网页请求地址key
FOUNDATION_EXTERN NSString *const RequestURLkey;
// WebViewNav的导航类型key
FOUNDATION_EXTERN NSString *const NavBarStyleTypekey;
// 网络状态类型key
FOUNDATION_EXTERN NSString *const NetWorkStatusTypekey;
// Web页面key
FOUNDATION_EXTERN NSString *const WebViewTypekey;
// model下标key
FOUNDATION_EXTERN NSString *const DataIndex;


/********** 网络请求地址 ***********/

// 服务地址
FOUNDATION_EXTERN NSString *const HTURL;
FOUNDATION_EXTERN NSString *const HTURL_Test;


// 首页
FOUNDATION_EXTERN NSString *const CityTravel_URL;

// 发现
FOUNDATION_EXTERN NSString *const Find_URL;
// 更多视频
FOUNDATION_EXTERN NSString *const ExploreMore_URL;
@end
