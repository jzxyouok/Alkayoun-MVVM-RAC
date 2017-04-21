//
//  RWCityTraveProtocolImpl.m
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWCityTraveProtocolImpl.h"
#import "RWBannerModel.h"
#import "RWCityTravelItemModel.h"

@interface RWCityTraveProtocolImpl ()

//banner数组
@property (nonatomic, strong) NSMutableArray *bannerData;

//item数据
@property (nonatomic, strong) NSMutableArray *itemData;

//首页model数据
@property (nonatomic, strong) NSMutableDictionary *travelData;

//加载更多
@property (nonatomic, copy) NSString *next_start;

@end


@implementation RWCityTraveProtocolImpl

//请求首页网络数据
- (RACSignal *)requestCityTravelDataSignal:(NSString *)requestUrl
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        //网络请求信号 内blok
        HTURLSessionTask *task = [HTNetWorking getWithUrl:requestUrl refreshCache:YES showHUD:@"loading..." success:^(id response) {
            
            [self.bannerData removeAllObjects];
            [self.itemData removeAllObjects];
            
            NSDictionary *responseDic = response;
            NSArray *responseArr  = responseDic[@"data"][@"elements"];
            
            self.next_start = [NSString stringWithFormat:@"%@",responseDic[@"data"][@"next_start"]];
            
            [responseArr enumerateObjectsUsingBlock:^(NSDictionary *data, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([data[@"type"] integerValue] == 1) { //广告数据
                    
                    [data[@"data"][0] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        RWBannerModel *bannerModel = [RWBannerModel modelWithJSON:obj];
                        [self.bannerData addObject:bannerModel];
                    }];
                }else if ([data[@"type"] integerValue] == 4){// item数据
                    
                    [data[@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        RWCityTravelItemModel *bannerModel = [RWCityTravelItemModel modelWithJSON:obj];
                        [self.itemData addObject:bannerModel];
                    }];
                }

            }];
            
            [self.travelData setValue:self.bannerData forKey:BannerDatakey];
            [self.travelData setValue:self.itemData forKey:TravelDatakey];
            //发送信号，让订阅者执行视图
            [subscriber sendNext:self.travelData];
            //信号完成
            [subscriber sendCompleted];
            
        } fail:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
        

    }];
}


//请求更多数据
- (RACSignal *)requestCityTravelMoreDataSignal:(NSString *)requestUrl
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSDictionary *parms = @{@"next_start":(self.next_start ? self.next_start : @"1")};
        //网络请求
        HTURLSessionTask *task = [HTNetWorking getWithUrl:requestUrl refreshCache:YES showHUD:@"loading..." params:parms success:^(id response) {
            
            NSDictionary *responseDic = response;
            NSArray *responseArr = responseDic[@"data"][@"elements"];
            self.next_start = [NSString stringWithFormat:@"%@",responseDic[@"data"][@"next_start"]];
            
            [responseArr enumerateObjectsUsingBlock:^(NSDictionary *data, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([data[@"type"] integerValue] == 4) {//item数据
                    
                    [data[@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        RWCityTravelItemModel *bannerModel = [RWCityTravelItemModel modelWithJSON:obj];
                        [self.itemData addObject:bannerModel];
                    }];
                }
            }];
            
            [self.travelData setValue:self.itemData forKey:TravelDatakey];
            
            [subscriber sendNext:self.travelData];
            [subscriber sendCompleted];
            
        } fail:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
        
    }];
}

#pragma mark - getter
- (NSMutableArray *)bannerData
{
    return HT_LAZY(_bannerData, @[].mutableCopy);
}

- (NSMutableArray *)itemData
{
    return HT_LAZY(_itemData, @[].mutableCopy);
}

-(NSMutableDictionary *)travelData
{
    return HT_LAZY(_travelData, @{}.mutableCopy);
}












@end
