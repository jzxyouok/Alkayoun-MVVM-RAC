//
//  RWCityTravelNotesController.m
//  MVVM+RAC_Demo
//
//  Created by ___AlkaYoung___ on 2017/4/18.
//  Copyright © 2017年 风鼎科技. All rights reserved.
//
//  Email: alkayoun@foxmail.com
//

#import "RWCityTravelNotesController.h"
#import "RWCityTravelViewModel.h"//viewModel
#import "RWTextField.h"//搜索框textField
#import "RWTableViewBindingHelper.h"//tableView的RAC
#import "RWCityTravelCell.h"//cell

@interface RWCityTravelNotesController ()<UITextFieldDelegate,UITableViewDelegate>
//tableView
@property (nonatomic, strong)UITableView *tableView;
//tableViewBlinding
@property (nonatomic, strong)RWTableViewBindingHelper *tripBindingHelper;
/**
 *  bind ViewModel
 */
@property (strong, nonatomic, readonly) RWCityTravelViewModel *viewModel;
/**
 *  banner图数据
 */
@property (strong, nonatomic) NSMutableArray *bannerData;
/**
 *  rightButton
 */
@property (strong, nonatomic) UIButton *rightButton;
/**
 *  leftButton
 */
@property (strong, nonatomic) UIButton *leftButton;
/**
 *  是否为搜索
 */
@property (assign , nonatomic) BOOL  isSearch;
/**
 *  搜索框
 */
@property (strong, nonatomic) RWTextField *searchTextField;

//********************自定义按钮***********//
@property (nonatomic, strong) UIButton *middleButton;

@end

@implementation RWCityTravelNotesController
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SetColor(251, 247, 237);
    
    [self setNavigationBar];
    [self.view addSubview:self.middleButton];
}

#pragma mark - rewriteFatherMethod
-(void)bindViewModel
{
    //实现父类网络监听，准备订阅信号，进行网络请求
    [super bindViewModel];
    
    self.isSearch = NO;
    //界面设置
    self.tripBindingHelper  = [RWTableViewBindingHelper bindingHelperForTableView:self.tableView sourceSignal:RACObserve(self.viewModel, travelData) selectionCommand:self.viewModel.travelDetailCommand templateCell:@"RWCityTravelCell" withViewModel:self.viewModel];
    
    self.tripBindingHelper.delegate = self;
    
    
    @weakify(self)
    //**************************************下拉刷新**************************************
    
    
    
    
    //**************************************搜索框信号监听**************************************************//
    //1.textFieldDelegate监听开始编辑状态
    [[self rac_signalForSelector:@selector(textFieldDidBeginEditing:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        if (tuple.first == self.searchTextField) {
            [self.rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.rightButton setTitle:@"取消" forState:UIControlStateNormal];
            self.isSearch = YES;
        }
    }];
    //2.textFieldDelegate监听完成编辑状态
    [[self rac_signalForSelector:@selector(textFieldDidEndEditing:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        if (tuple.first == self.searchTextField) {
            self.isSearch = NO;
            [self.rightButton setImage:[UIImage imageNamed:@"tabbar_user_button_image_22x22_"] forState:UIControlStateNormal];
            [self.rightButton setTitle:@"" forState:UIControlStateNormal];
        }
    }];
    
    //*****************************************导航栏右侧按钮监听************************************************
    RAC(self.viewModel, isSearch) = RACObserve(self, isSearch);
    self.rightButton.rac_command = self.viewModel.rightBarButtonItemCommand;
    
    [self.viewModel.rightBarButtonItemCommand.executionSignals.switchToLatest subscribeNext:^(NSNumber *isSearch) {
        @strongify(self)
        if ([isSearch boolValue]) {
            //搜索状态下 右侧按钮为“取消”
            [self.searchTextField resignFirstResponder];
        }else{
            NSLog(@"页面跳转");
        }
    }];
    
    
}

#pragma mark - button
- (void)_clickButton
{
    //执行命令
    
    [self.viewModel.travelMoreDataCommand execute:@1];
}

#pragma mark - method
- (void)setNavigationBar
{
    // 导航栏navigationItem
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [searchView addSubview:self.searchTextField];
    self.navigationItem.titleView = searchView;
    
}

#pragma mark - lazy
- (UIButton *)rightButton
{
    return HT_LAZY(_rightButton, ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 30, 20);
        [button setImage:[UIImage imageNamed:@"tabbar_user_button_image_22x22_"] forState:UIControlStateNormal];
        button.titleLabel.font = HTSetFont(@"DamascusLight", 14);
        button;
    }));
}
- (UIButton *)leftButton
{
    return HT_LAZY(_leftButton, ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 40, 40);
        [button setImage:[UIImage imageNamed:@"breadTrip_logo"] forState:UIControlStateNormal];
        button.adjustsImageWhenHighlighted = NO;
        button;
    }));
}
- (RWTextField *)searchTextField
{
    return HT_LAZY(_searchTextField, ({
        
        RWTextField *view = [[RWTextField alloc] initWithFrame:CGRectMake(15, 8, SCREEN_WIDTH-140, 25)];
        view.delegate = self;
        view;
    }));
}

- (UITableView *)tableView
{
    return HT_LAZY(_tableView, ({
    
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.rowHeight = 180;
        [self.view addSubview:tableView];
        tableView;
    }));
}

//******中间按钮****//
- (UIButton *)middleButton
{
    return  HT_LAZY(_middleButton, ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.view.centerX - 20, self.view.centerY - 20, 40, 40);
        [button setTitle:@"请求数据" forState:UIControlStateNormal];
        button.adjustsImageWhenHighlighted = NO;
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(_clickButton) forControlEvents:UIControlEventTouchUpInside];
        button;
    }));
}


@end
