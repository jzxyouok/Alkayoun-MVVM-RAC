//
//  HTViewModel.m
//  HeartTrip
//
//  Created by 熊彬 on 17/2/28.
//  Copyright © 2017年 BinBear. All rights reserved.
//

#import "HTViewModel.h"

@interface HTViewModel ()

@property (strong, nonatomic, readwrite) id<HTViewModelService> services;
@property (strong, nonatomic, readwrite) RACCommand *requestDataCommand;
@property (assign, nonatomic, readwrite) HTNavBarStyleType navBarStyleType;
@property (copy, nonatomic, readwrite) NSString *title;

@end

@implementation HTViewModel
- (instancetype)initWithServices:(id<HTViewModelService>)services params:(NSDictionary *)params
{
    
    if ([super init]) {

        self.services = services;
        self.navBarStyleType = [params[NavBarStyleTypekey] integerValue];
        self.title = params[ViewTitlekey];
        @weakify(self);
        self.requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSLog(@"_____HTViewModel____执行命令");
            @strongify(self);
            return [[self executeRequestDataSignal:input] takeUntil:self.rac_willDeallocSignal];
        }];
        
        [self initialize];
    }
    return self;
}

- (void)initialize{}

- (RACSignal *)executeRequestDataSignal:(id)input
{
    NSLog(@"_____HTViewModel____返回空信号给到命令，循环监听信号知道信号dealloc");
    return [RACSignal empty];
}
@end
