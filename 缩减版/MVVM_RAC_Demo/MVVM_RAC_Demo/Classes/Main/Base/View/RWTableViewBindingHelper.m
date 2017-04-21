//
//  RWTableViewBindingHelper.m
//  MVVM_RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/20.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWTableViewBindingHelper.h"
#import "RWViewModel.h"
#import <UIScrollView+EmptyDataSet.h>

#import "RWReactiveView.h"

@interface RWTableViewBindingHelper ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

//表视图
@property (nonatomic, strong)UITableView *tableView;
//数据
@property (nonatomic, strong)NSArray *data;
//点击cell的命令监听
@property (nonatomic, strong)RACCommand *didSelectionCommand;
//cell重用标识
@property (nonatomic, copy)NSString *cellIdentifire;
//viewModel请求数据，得到模型，给到view显示
@property (nonatomic, strong) RWViewModel *viewModel;

@end

@implementation RWTableViewBindingHelper
#pragma mark - init
- (instancetype)initWithTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)didSelectionCommand withCellType:(NSDictionary *)cellTypeDic withVeiwModel:(RWViewModel *)viewModel
{
    if (self =  [super init]) {
        _tableView = tableView;
        _data = [NSArray array];
        _didSelectionCommand = didSelectionCommand;
        _viewModel = viewModel;
        
        //订阅传送进来的信号：self.viewModel travelData  数据的改变
        @weakify(self)
        [source subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            self.data = x;
            [self.tableView reloadData];
        }];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        
        NSString *cellType = cellTypeDic[@"cellType"];
        _cellIdentifire = cellTypeDic[@"cellName"];
        
        if ([cellType isEqualToString:@"codeType"]) {
            
            Class cell = NSClassFromString(_cellIdentifire);
            [_tableView registerClass:cell forCellReuseIdentifier:_cellIdentifire];
        }else{
            
            UINib *templateCellNib = [UINib nibWithNibName:_cellIdentifire bundle:nil];
            [_tableView registerNib:templateCellNib forCellReuseIdentifier:_cellIdentifire];
        }
        
        //此处订阅request命令信号:无网络返回signal empty，有网络，请求到数据发送信号，此处能接收到信号。-->隐藏空白界面
        [viewModel.requestDataCommand.executing subscribeNext:^(NSNumber * executing) {
//            @strongify(self)
//            UIView *emptyDataSetView = [self.tableView.subviews.rac_sequence objectPassingTest:^(UIView * view) {
//                return [NSStringFromClass(view.class) isEqualToString:@"DZNEmptyDataSetView"];
//            }];
//            emptyDataSetView.alpha = 1.0 - executing.floatValue;
        }];
        
        
    }
    return self;
}



#pragma mark - 方法实现
+(instancetype)bindingHelperForTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)didSelectionCommand templateCell:(NSString *)templateCell withViewModel:(RWViewModel *)viewModel
{
    NSDictionary *cellDic = @{@"cellType":@"codeType",@"cellName":templateCell};
    return [[RWTableViewBindingHelper alloc]initWithTableView:tableView sourceSignal:source selectionCommand:didSelectionCommand withCellType:cellDic withVeiwModel:viewModel];
}



+(instancetype)bindingHelperForTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source selectionCommand:(RACCommand *)didSelectionCommand templateCellWithNib:(NSString *)templateCell withViewModel:(RWViewModel *)viewModel
{
    NSDictionary *cellDic = @{@"cellType":@"nibType",@"cellName":templateCell};
    return [[RWTableViewBindingHelper alloc]initWithTableView:tableView sourceSignal:source selectionCommand:didSelectionCommand withCellType:cellDic withVeiwModel:viewModel];
}

#pragma mark - life
- (void)dealloc
{
    self.delegate = nil;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = (self.data.count == 0)? YES : NO;
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<RWReactiveView> cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifire];
    //给cell赋值
    [cell bindViewModel:self.viewModel withParams:@{DataIndex:@(indexPath.row)}];
    
    return (UITableViewCell*)cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.didSelectionCommand execute:self.data[indexPath.row]];//发送信号
    //如果控制器实现方法，则去实现吧！！
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    
    NSString *text;
    if (self.viewModel.netWorkStatus == RealStatusNotReachable) {
        
        text = @"网络君失联了,请检查你的网络设置!";
    }else{
        text = @"此页面可能去火星旅游了!";
    }
    UIFont *font = HTSetFont(@"HelveticaNeue-Light", 17.0);
    UIColor *textColor = [UIColor grayColor];
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    if (self.viewModel.netWorkStatus == RealStatusNotReachable) {
        return [UIImage imageNamed:@"NoNetwork"];
    }else{
        return [UIImage imageNamed:@"NoData"];
    }
    
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSString *text;
    if (self.viewModel.netWorkStatus == RealStatusNotReachable) {
        
        text = @"检查网络设置";
    }else{
        text = @"重新加载";
    }
    UIFont *font = HTSetFont(@"HelveticaNeue-Light", 15.0);
    UIColor *textColor = [UIColor lightGrayColor];
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSString *imageName = @"";
    
    if (state == UIControlStateNormal) imageName = [imageName stringByAppendingString:@"button_background_normal"];
    if (state == UIControlStateHighlighted) imageName = [imageName stringByAppendingString:@"button_background_highlight"];
    
    UIEdgeInsets capInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    UIEdgeInsets rectInsets = UIEdgeInsetsMake(-19.0, -61.0, -19.0, -61.0);
    
    return [[[UIImage imageNamed:imageName] resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
}
#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return (self.data.count == 0) ? YES : NO;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return SetColor(251, 247, 237);
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    //点击按钮，如果能够跳转页面到设置，则跳转，不可以的话就重写请求数据
    if (self.viewModel.netWorkStatus == RealStatusNotReachable) {
        NSURL *url= [NSURL URLWithString:@"prefs:root=Network"];
        if( [[UIApplication sharedApplication] canOpenURL:url] ) {
            
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication] openURL:url options:@{}completionHandler:nil];
            }else{
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }else{
        [self.viewModel.requestDataCommand execute:@1];
    }
}

#pragma mark - UITableViewDelegate forwarding
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([self.delegate respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self.delegate respondsToSelector:aSelector]) {
        return self.delegate;
    }
    return [super forwardingTargetForSelector:aSelector];
}



















@end
