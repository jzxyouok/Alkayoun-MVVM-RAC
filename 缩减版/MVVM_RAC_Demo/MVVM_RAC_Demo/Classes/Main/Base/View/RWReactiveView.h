//
//  RWReactiveView.h
//  MVVM_RAC_Demo
//
//  Created by fdiosone on 2017/4/20.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RWReactiveView <NSObject>
//绑定一个ViewModel 给 view

- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params;
@end
