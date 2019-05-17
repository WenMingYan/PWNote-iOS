//
//  PWDialogTestViewController.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWDialogTestViewController.h"
#import "TYSmartActionDialog.h"
#import "TYSmartActionDialogSingleSectionDefaultModel.h"
#import "TYSmartActionDialogSliderNumberDefaultModel.h"
#import "TYSmartActionDialogTimerDefaultModel.h"
#import "TYSmartActionDialogSliderColoursModel.h"
#import "TYSmartActionDialogTempColorSliderDefaultModel.h"
#import "TYSmartActionDialogSliderColoursSaturabilityIntensityDefaultModel.h"

@interface PWDialogTestViewController () <UITableViewDataSource, UITableViewDelegate, TYDeviceFunctionDelegate,TYDFCompleteDialogEventDelegate>

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

- (TYSmartActionDialogSingleSectionDefaultModel *)singleDialogModel {
    TYSmartActionDialogSingleSectionDefaultModel *model1 = [[TYSmartActionDialogSingleSectionDefaultModel alloc] init];
    model1.dialogTitle = @"单选";
    model1.dialogIconName = XIconDelete;
    model1.dialogOptions = @[@"Option1",@"Option2"];
    model1.originalSelectIndex = 1;
    return model1;
}

- (TYSmartActionDialogSliderNumberDefaultModel *)TemperatureSliderModel {
    TYSmartActionDialogSliderNumberDefaultModel *model1 = [[TYSmartActionDialogSliderNumberDefaultModel alloc] init];
    model1.dialogTitle = @"温度";
    model1.dialogMax = 45;
    model1.dialogIconName = XIconDelete;
    model1.dialogMin = 16;
    model1.dialogStep = 1;
    model1.dialogStartValue = 25;
    model1.modelType = TYSmartActionDialogNumberModelType_Temperature;
    return model1;
}

- (TYSmartActionDialogSliderNumberDefaultModel *)intensitySliderModel {
    TYSmartActionDialogSliderNumberDefaultModel *model1 = [[TYSmartActionDialogSliderNumberDefaultModel alloc] init];
    model1.dialogTitle = @"亮度";
    model1.dialogMax = 100;
    model1.dialogIconName = XIconDelete;
    model1.dialogMin = 0;
    model1.dialogStep = 1;
    model1.dialogStartValue = 50;
    model1.modelType = TYSmartActionDialogNumberModelType_Intensity;
    return model1;
}

- (TYSmartActionDialogSliderNumberDefaultModel *)saturabilityModel {
    TYSmartActionDialogSliderNumberDefaultModel *model1 = [[TYSmartActionDialogSliderNumberDefaultModel alloc] init];
    model1.dialogTitle = @"饱和度";
    model1.dialogMax = 1000;
    model1.dialogMin = 10;
    model1.dialogIconName = XIconDelete;
    model1.dialogStep = 5;
    model1.dialogStartValue = 100;
    model1.modelType = TYSmartActionDialogNumberModelType_Saturability;
    return model1;
}

- (TYSmartActionDialogTimerDefaultModel *)timeSetModel {
    TYSmartActionDialogTimerDefaultModel *model = [[TYSmartActionDialogTimerDefaultModel alloc] init];
    model.timerSetType = TYSmartActionDialogTimerSetType_Seconds;
    model.hasSetTimer = NO;
    model.dialogIconName = XIconDelete;
    model.dialogTimer = 12344;
    model.dialogTitle = @"计时设置";
    return model;
}


- (TYSmartActionDialogTimerDefaultModel *)timeMinModel {
    TYSmartActionDialogTimerDefaultModel *model = [[TYSmartActionDialogTimerDefaultModel alloc] init];
    model.timerSetType = TYSmartActionDialogTimerSetType_Minutes;
    model.hasSetTimer = NO;
    model.dialogTimer = 12344;
    model.dialogIconName = XIconDelete;
    model.dialogTitle = @"计时设置";
    return model;
}

- (TYSmartActionDialogTimerDefaultModel *)timeModel {
    TYSmartActionDialogTimerDefaultModel *model = [[TYSmartActionDialogTimerDefaultModel alloc] init];
    model.timerSetType = TYSmartActionDialogTimerSetType_Seconds;
    model.hasSetTimer = YES;
    model.dialogTimer = 12344;
    model.dialogIconName = XIconDelete;
    model.dialogTitle = @"倒计时";
    return model;
}

- (TYSmartActionDialogSliderColoursModel *)coloursModel {
    TYSmartActionDialogSliderColoursModel *model1 = [[TYSmartActionDialogSliderColoursModel alloc] init];
    model1.dialogTitle = @"颜色选择";
    model1.dialogIconName = XIconDelete;
    model1.originalColorProgress = 75;
    return model1;
}

- (TYSmartActionDialogTempColorSliderDefaultModel *)twoModel {
    TYSmartActionDialogTempColorSliderDefaultModel *model = [[TYSmartActionDialogTempColorSliderDefaultModel alloc] init];
    model.dialogTitle = @"色彩饱和度";
    model.dialogIconName = XIconDelete;
    TYSmartActionDialogSliderColoursModel *colorModel = [self coloursModel];
    TYSmartActionDialogSliderNumberDefaultModel *tempModel = [self saturabilityModel];
    model.coloursModel = colorModel;
    model.saturabilityModel = tempModel;
    return model;
}

- (TYSmartActionDialogSliderColoursSaturabilityIntensityDefaultModel *)threeModel {
    TYSmartActionDialogSliderColoursSaturabilityIntensityDefaultModel *model = [[TYSmartActionDialogSliderColoursSaturabilityIntensityDefaultModel alloc] init];
    model.dialogTitle = @"色彩饱和度亮度";
    model.iconName = XIconDelete;
    TYSmartActionDialogSliderColoursModel *colorModel = [self coloursModel];
    model.coloursModel = colorModel;
    TYSmartActionDialogSliderNumberDefaultModel *tempModel = [self saturabilityModel];
    model.saturabilityModel = tempModel;
    TYSmartActionDialogSliderNumberDefaultModel *iModel = [self intensitySliderModel];
    model.intensityModel = iModel;
    return model;
}

- (void)showSingleDialog {
    TYSmartActionDialogSingleSectionDefaultModel *model1 = [self singleDialogModel];
    [TYSmartActionDialog showSelectorDialogWithModel:model1 callback:^(NSInteger index) {
        NSLog(@"%@",[NSString stringWithFormat:@"选中第%ld个",(long)index]);
    }];
}

- (void)showTemperatureSlider {
    TYSmartActionDialogSliderNumberDefaultModel *model1 = [self TemperatureSliderModel];
    [TYSmartActionDialog showSliderNumberDialogWithModel:model1 callback:^(double number) {
        NSLog(@"%@",[NSString stringWithFormat:@"实数：%f",number]);
    }];
}

- (void)showIntensitySlider {
    TYSmartActionDialogSliderNumberDefaultModel *model1 = [self intensitySliderModel];
    [TYSmartActionDialog showSliderNumberDialogWithModel:model1 callback:^(double number) {
        NSLog(@"%@",[NSString stringWithFormat:@"实数：%f",number]);
    }];
}

- (void)showSaturabilitySlider {
    TYSmartActionDialogSliderNumberDefaultModel *model1 = [self saturabilityModel];
    [TYSmartActionDialog showSliderNumberDialogWithModel:model1 callback:^(double number) {
        NSLog(@"%@",[NSString stringWithFormat:@"实数：%f",number]);
    }];
}


- (void)showColorfulSlider {
    TYSmartActionDialogSliderColoursModel *model1 = [self coloursModel];
    [TYSmartActionDialog showSliderColoursDialogWithModel:model1 callback:^(double number,UIColor *color) {
        NSLog(@"选择的颜色为%@,%f",color,number);
        
    }];
}

- (void)showTimerSet {
    TYSmartActionDialogTimerDefaultModel *model = [self timeSetModel];
    [TYSmartActionDialog showTimerFunctionDialogWithModel:model callback:^(NSTimeInterval timer) {
        NSLog(@"%@",[NSString stringWithFormat:@"设定时间为：%f",timer]);
    }];
}

- (void)showTimer {
    TYSmartActionDialogTimerDefaultModel *model = [self timeModel];
    [TYSmartActionDialog showTimerFunctionDialogWithModel:model callback:^(NSTimeInterval timer){
        NSLog(@"点击取消 当前时间为：%f",timer);
    }];
}


- (void)showTwoSlider {
    TYSmartActionDialogTempColorSliderDefaultModel *model = [self twoModel];
    [TYSmartActionDialog showColoursSaturabilitySliderDialogWithModel:model andColoursCallback:^(double number, UIColor *color) {
        NSLog(@"number = %f,color = %@",number,color);
    } andSaturabilityCallback:^(double number1) {
        NSLog(@"number = %f",number1);
    }];
}


- (void)showThreeSlider {
    TYSmartActionDialogSliderColoursSaturabilityIntensityDefaultModel *model = [self threeModel];
    [TYSmartActionDialog showColoursSaturabilityIntensitySliderDialogWithModel:model andColoursCallback:^(double number, UIColor *color) {
        NSLog(@"number = %f,color = %@",number,color);
    } andSaturabilityCallback:^(double number1) {
        NSLog(@"number = %f",number1);
    } andIntensityCallback:^(double number1) {
        NSLog(@"number = %f",number1);
    }];
}

- (void)showCompleteHeader {
    NSArray<id<TYSmartActionDialogModelProtocol>> *array = @[
                                                         [self singleDialogModel],
                                                         [self timeModel],
                                                         [self timeMinModel],
                                                         [self timeSetModel],
                                                         [self TemperatureSliderModel],
                                                         [self saturabilityModel],
                                                         [self coloursModel],
                                                         [self intensitySliderModel],
                                                         [self twoModel],
                                                         [self threeModel],
                                                         ];
    [TYSmartActionDialog showDialogWithModels:array andDelegate:self];
}

#pragma mark TYDFCompleteDialogEventDelegate


- (void)dialogSelectIndex:(NSInteger)index inPageIndex:(NSInteger)pageIndex {
    NSLog(@"selectIndex:%ld,index = %ld",(long)index,(long)pageIndex);
}
- (void)dialogSliderWithValue:(double)number inPageIndex:(NSInteger)pageIndex {
    NSLog(@"sliderValue:%f,index = %ld",number,(long)pageIndex);
}
- (void)dialogSliderWithProgress:(NSInteger)progress andColor:(UIColor *)color inPageIndex:(NSInteger)pageIndex {
    NSLog(@"progressValue:%ld,index = %ld,color = %@",(long)progress,(long)pageIndex,color);
}

// 色彩饱和度滑块
- (void)dialogColoursSaturabilityWithColor:(UIColor *)color
                             colorProgress:(NSInteger)colorProgress
                         saturabilityValue:(double)number {
    NSLog(@"saturabilityValue:%f,colorProgress = %ld,color = %@",number,colorProgress,color);
}
// 色彩饱和度亮度滑块
- (void)dialogColoursSaturabilityWithColor:(UIColor *)color
                             colorProgress:(NSInteger)colorProgress
                         saturabilityValue:(double)saturability
                            intensityValue:(double)intensity {
    NSLog(@"intensityvalue = %f, saturabilityValue:%f,colorProgress = %ld,color = %@",intensity,saturability,colorProgress,color);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {// 单选
        [self showSingleDialog];
    }
    if (indexPath.row == 1) {// 温度
        [self showTemperatureSlider];
    }
    if (indexPath.row == 2) {// 亮度
        [self showIntensitySlider];
    }
    if (indexPath.row == 3) {// 饱和度
        [self showSaturabilitySlider];
    }
    if (indexPath.row == 4) {// 颜色
        [self showColorfulSlider];
    }
    if (indexPath.row == 5) {// 计时器
        [self showTimerSet];
    }
    if (indexPath.row == 6) {
        [self showTimer];
    }
    
    if (indexPath.row == 7) {
        [self showTwoSlider];
    }
    if (indexPath.row == 8) {
        [self showThreeSlider];
    }
    if (indexPath.row == 9) {
        [self showCompleteHeader];
    }
}

#pragma mark - TYDeviceFunctionDelegate

- (NSArray<id<TYSHDeviceQuickControlItemData>> *)dialogTitleDatas {
    return @[];
}

- (NSArray *)names {
    return @[
             @"单选",
             @"显示温度滑块",
             @"显示亮度滑块",
             @"显示饱和度滑块",
             @"显示色彩滑块",
             @"显示设置计时器滑块",
             @"显示倒计时滑块",
             @"显示颜色饱和度滑块",
             @"显示颜色饱和度亮度滑块",
             @"显示复杂Dialog",
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
