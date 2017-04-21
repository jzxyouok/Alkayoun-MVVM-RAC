//
//  RWConst.m
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/17.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWConst.h"

@implementation RWConst
/********** Project Key ***********/

// 首页banner数据key
NSString *const  BannerDatakey = @"BannerDatakey";
// 首页热门游记数据key
NSString *const  TravelDatakey = @"TravelDatakey";
// 发现视频数据key
NSString *const  FindVideoDatakey = @"FindVideoDatakey";
// 发现feed数据key
NSString *const  FindFeedDatakey = @"FindFeedDatakey";
// 经度key
NSString *const  Longitudekey = @"Longitudekey";
// 纬度key
NSString *const  Latitudekey = @"Latitudekey";
// 城市名key
NSString *const  CityNamekey = @"CityNamekey";
// 网页标题key
NSString *const  ViewTitlekey = @"ViewTitlekey";
// 网页请求地址key
NSString *const  RequestURLkey = @"RequestURLkey";
// ViewNav的导航类型key
NSString *const  NavBarStyleTypekey = @"NavBarStyleTypekey";
// ViewNav的导航类型key
NSString *const  NetWorkStatusTypekey = @"NetWorkStatusTypekey";
// Web页面key
NSString *const  WebViewTypekey = @"WebViewTypekey";
// model下标key
NSString *const DataIndex = @"DataIndex";

/********** 网络请求地址 ***********/

// 服务地址
NSString *const  HTURL = @"http://api.breadtrip.com";
NSString *const  HTURL_Test = @"http://api.breadtrip.com";


// 首页
NSString *const  CityTravel_URL = @"/v2/index/";

// 发现
NSString *const  Find_URL = @"/hunter/feeds/";
// 更多视频
NSString *const  ExploreMore_URL = @"/hunter/videos/";

@end
