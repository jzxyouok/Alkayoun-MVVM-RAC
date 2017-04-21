//
//  RWViewModelServicesImpl.h
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import <Foundation/Foundation.h>
#import "RWViewModelService.h"
//数据服务viewModel，由此创建数据model
@interface RWViewModelServicesImpl : NSObject<RWViewModelService>


- (instancetype)initModelServiceImpl;

@end
