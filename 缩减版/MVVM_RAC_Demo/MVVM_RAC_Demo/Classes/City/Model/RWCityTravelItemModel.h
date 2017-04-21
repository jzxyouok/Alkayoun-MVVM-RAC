//
//  RWCityTravelItemModel.h
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import <Foundation/Foundation.h>
#import "RWUerModel.h"
@class RWUerModel;

@interface RWCityTravelItemModel : NSObject
/**
 *  item背景
 */
@property (copy, nonatomic) NSString *cover_image;
/**
 *  游记标题
 */
@property (copy, nonatomic) NSString *name;
/**
 *  创建时间
 */
@property (copy, nonatomic) NSString *first_day;
/**
 *  游记地点
 */
@property (copy, nonatomic) NSString *popular_place_str;
/**
 *  游记天数
 */
@property (strong, nonatomic) NSNumber *day_count;
/**
 *  浏览人数
 */
@property (strong, nonatomic) NSNumber *view_count;
/**
 *  游记id
 */
@property (strong, nonatomic) NSNumber *travelID;
/**
 *  用户model
 */
@property (strong, nonatomic) RWUerModel *user;

@end
