//
//  RWTableViewBindingHelper.h
//  MVVM_RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/20.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import <Foundation/Foundation.h>

@class RWViewModel;//数据

@interface RWTableViewBindingHelper : NSObject

@property (weak, nonatomic) id<UITableViewDelegate> delegate;
/**
 代码创建cell时调用
 
 @param tableView tableview
 @param source 数据信号
 @param didSelectionCommand cell选中信号
 @param templateCell cell的类名
 @param viewModel viewModel
 @return 配置好的tableview
 */
+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)didSelectionCommand
                              templateCell:(NSString *)templateCell
                             withViewModel:(RWViewModel *)viewModel;
/**
 xib创建cell时调用
 
 @param tableView tableview
 @param source 数据信号
 @param didSelectionCommand cell选中信号
 @param templateCell Nib的类名
 @param viewModel viewModel
 @return 配置好的tableview
 */
+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)didSelectionCommand
                       templateCellWithNib:(NSString *)templateCell
                             withViewModel:(RWViewModel *)viewModel;

@end
