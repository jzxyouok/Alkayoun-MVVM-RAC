//
//  RWUerModel.h
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import <Foundation/Foundation.h>

@interface RWUerModel : NSObject
/**
 *  用户头像
 */
@property (copy, nonatomic) NSString *avatar_m;
/**
 *  用户名
 */
@property (copy, nonatomic) NSString *name;
/**
 *  用户id
 */
@property (strong, nonatomic) NSNumber *userID;

@end
