//
//  RWViewModelService.h
//  MVVM+RAC_Demo
//
//  Created by fdiosone on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWViewModelProtocolImpl.h"
//


//定义好数据请求方法，返回model
@protocol RWViewModelService <NSObject>
// 获取首页服务
- (id<RWViewModelProtocolImpl>) getCityTravelService;

// 获取发现服务
- (id<RWViewModelProtocolImpl>) getFindService;
// 获取探索视频服务
- (id<RWViewModelProtocolImpl>) getExploreMoreService;

// 获取目的地服务


// 获取我的服务

// 获得web服务
- (id<RWViewModelProtocolImpl>)getWebService;
@end
