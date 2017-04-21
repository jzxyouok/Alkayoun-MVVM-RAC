//
//  RWServerConfig.m
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/17.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWServerConfig.h"

static NSString *RWConfigEnv;

@implementation RWServerConfig

//// env: 环境参数 00: 测试环境 01: 生产环境
+ (void)setRWConfigEnv:(NSString *)value
{
    RWConfigEnv = value;
}


//返回环境参数
+ (NSString *)RWConfigEnv
{
    return RWConfigEnv;
}

//获取服务器地址
+ (NSString *)getRWServerAddr
{
    if ([RWConfigEnv isEqualToString:@"00"]) {
        return HTURL_Test;
    }else{
        return HTURL;
    }
}
@end
