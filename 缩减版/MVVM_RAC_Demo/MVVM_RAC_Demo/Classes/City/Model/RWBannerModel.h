//
//  RWBannerModel.h
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import <Foundation/Foundation.h>

@interface RWBannerModel : NSObject
/**
 *  banner跳转地址
 */
@property (copy, nonatomic) NSString *html_url;
/**
 *  banner图地址
 */
@property (copy, nonatomic) NSString *image_url;

@end
