//
//  RWCityTravelItemModel.m
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWCityTravelItemModel.h"

@implementation RWCityTravelItemModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"travelID" : @"id"};
}
@end
