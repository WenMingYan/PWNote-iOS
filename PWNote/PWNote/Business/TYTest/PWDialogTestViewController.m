//
//  PWDialogTestViewController.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWDialogTestViewController.h"
#import "TYDeviceFunctionDialog.h"
#import "TYDeviceSingleSectionFunctionDefaultModel.h"
#import "TYDeviceSliderFuctionDefaultModel.h"
#import "TYDFTimerDefaultModel.h"

@interface PWDialogTestViewController () <UITableViewDataSource, UITableViewDelegate, TYDeviceFunctionDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PWDialogTestViewController

__PW_ROUTER_REGISTER__

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)initView {
    self.title = @"test dialog";
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [[self names] objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self names].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)showSingleDialog {
    TYDeviceSingleSectionFunctionDefaultModel *model1 = [[TYDeviceSingleSectionFunctionDefaultModel alloc] init];
    model1.select = YES;
    TYDeviceSingleSectionFunctionDefaultModel *model2 = [[TYDeviceSingleSectionFunctionDefaultModel alloc] init];
    TYDeviceSingleSectionFunctionDefaultModel *model3 = [[TYDeviceSingleSectionFunctionDefaultModel alloc] init];
    TYDeviceSingleSectionFunctionDefaultModel *model4 = [[TYDeviceSingleSectionFunctionDefaultModel alloc] init];
    TYDeviceSingleSectionFunctionDefaultModel *model5 = [[TYDeviceSingleSectionFunctionDefaultModel alloc] init];
    TYDeviceSingleSectionFunctionDefaultModel *model6 = [[TYDeviceSingleSectionFunctionDefaultModel alloc] init];
    TYDeviceSingleSectionFunctionDefaultModel *model7 = [[TYDeviceSingleSectionFunctionDefaultModel alloc] init];
    NSMutableArray<TYDFSingleSectionModelProtocol> *array = [NSMutableArray<TYDFSingleSectionModelProtocol> array];
    [array addObject:model1];
    [array addObject:model2];
    [array addObject:model3];
    [array addObject:model4];
    [array addObject:model5];
    [array addObject:model6];
    [array addObject:model7];
    [TYDeviceFunctionDialog showSingleSelectFunctionDialogWithTitle:@"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题"
                                                      selectActions:array
                                                           callback:^(id<TYDFSingleSectionModelProtocol> model,
                                                                      NSInteger index) {
                                                               NSLog(@"%@",[NSString stringWithFormat:@"选中第%ld个",(long)index]);
                                                           }];
}


- (void)showSlider {
    TYDeviceSliderFuctionDefaultModel *model1 = [[TYDeviceSliderFuctionDefaultModel alloc] init];
    [TYDeviceFunctionDialog showSliderFuctionDialogWithTitle:@"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题" sliderModel:model1 callback:^(double number,UIColor *color) {
        NSLog(@"%@",[NSString stringWithFormat:@"实数：%f",number]);
    }];
}

- (void)showSingleSlider {
    TYDeviceSliderFuctionDefaultModel *model1 = [[TYDeviceSliderFuctionDefaultModel alloc] init];
    model1.modelType = TYDeviceSliderFuctionModelType_MonochromaticLight;
    [TYDeviceFunctionDialog showSliderFuctionDialogWithTitle:@"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题" sliderModel:model1 callback:^(double number,UIColor *color) {
        NSLog(@"%@",[NSString stringWithFormat:@"实数：%f",number]);
    }];
}

- (void)showColorfulSlider {
    TYDeviceSliderFuctionDefaultModel *model1 = [[TYDeviceSliderFuctionDefaultModel alloc] init];
    model1.modelType = TYDeviceSliderFuctionModelType_Colorful;
    [TYDeviceFunctionDialog showSliderFuctionDialogWithTitle:@"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题" sliderModel:model1 callback:^(double number,UIColor *color) {
        NSLog(@"%@",[NSString stringWithFormat:@"实数：%f",number]);
        NSLog(@"%@",[NSString stringWithFormat:@"颜色：%@",color]);
    }];
}


- (void)showTimerSet {
    TYDFTimerDefaultModel *model = [[TYDFTimerDefaultModel alloc] init];
    [TYDeviceFunctionDialog showTimerSetFunctionDialogWithTitle:@"123123" timerModel:model callback:^(NSTimeInterval timer) {
        NSLog(@"%@",[NSString stringWithFormat:@"设定时间为：%f",timer]);
    }];
}

- (void)showTimer {
    TYDFTimerDefaultModel *model = [[TYDFTimerDefaultModel alloc] init];
    [TYDeviceFunctionDialog showTimerFunctionDialogWithTitle:@"123123" timerModel:model callback:^() {
        NSLog(@"点击取消");
    }];
}

- (void)showCompleteHeader {
    //TODO: wmy 设置复杂头部和身子
    [TYDeviceFunctionDialog showCompleteFunctionDialogWithDelegate:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self showSingleDialog];
    }
    if (indexPath.row == 1) {
        [self showSlider];
    }
    if (indexPath.row == 2) {
        [self showTimerSet];
    }
    if (indexPath.row == 3) {
        [self showTimer];
    }
    if (indexPath.row == 4) {
        [self showSingleSlider];
    }
    if (indexPath.row == 5) {
        [self showColorfulSlider];
    }
    if (indexPath.row == 6) {
        [self showCompleteHeader];
    }
    
}

#pragma mark - TYDeviceFunctionDelegate

- (NSArray<id<TYSHDeviceQuickControlItemData>> *)dialogTitleDatas {
    return @[];
}

- (NSArray *)names {
    return @[
             @"single",
             @"Slider",
             @"TimerSet",
             @"Timer",
             @"SingleColorSlider",
             @"ColorfulSlider",
             @"CompleteHeader",
             ];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


+ (NSString *)urlName {
    return @"tydialog";
}

@end
