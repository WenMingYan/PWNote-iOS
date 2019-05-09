//
//  TYDFTimerView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYDFTimerSetView.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"
#import "TYDFTimerPickerView.h"

@interface TYDFTimerSetView () <TYDFTimerPickerViewDelegate,TYDFTimerPickerViewDataSource>

@property (nonatomic, strong) TYDFTimerPickerView *pickerView;

@property (nonatomic, copy) NSString *hours;
@property (nonatomic, copy) NSString *minutes;
@property (nonatomic, strong) NSString *seconds;

@property (nonatomic, strong) id<TYDFTimerModelProtocol> model; /**< 数据 */

@property (nonatomic, strong) UITableView *hourTableView;

@property (nonatomic, assign) NSInteger components;

@property (nonatomic, strong) UIButton *bottomBtn; /**< 底部按钮  */

@end


@implementation TYDFTimerSetView


#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)initView {
    [self addTimePicker];
    [self initPickerPosition];
    [self addSubview:self.bottomBtn];
    self.bottomBtn.layer.cornerRadius = TYScreenAdaptor(26);
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(TYScreenAdaptor(160));
        make.height.mas_equalTo(TYScreenAdaptor(48));
        make.bottom.mas_offset(self);
        make.centerX.mas_equalTo(self);
    }];
    
    self.bottomBtn.backgroundColor = [UIColor clearColor];
    [self.bottomBtn setTitleColor:HEXCOLOR(0x495054) forState:UIControlStateNormal];
    //TODO: wmy 目前没有start的国际化
    [self.bottomBtn setTitle:NSLocalizedString(@"action_start", nil) forState:UIControlStateNormal];
}

- (void)addTimePicker {
    
    self.components = 0;
    if (self.model.timerSetType == TYDFTimerSetType_Seconds) {
        NSInteger hour = self.model.timer / 60 / 60;
        if (hour) {
            self.components = 3;
        } else {
            self.components = 2;
        }
    } else {
        self.components = 2;
    }
    
    [self addSubview:self.pickerView];
    if (self.components == 2) {
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self);
            make.left.mas_equalTo(TYScreenAdaptor(20));
            make.right.mas_equalTo(-TYScreenAdaptor(20));
        }];
    } else {
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self);
            make.left.mas_equalTo(TYScreenAdaptor(10));
            make.right.mas_equalTo(-TYScreenAdaptor(10));
            
        }];
    }
    
}


- (void)initPickerPosition {
    if (self.minutes && self.hours && self.seconds) {
        [self.pickerView selectRow:60+self.hours.integerValue inComponent:0 animated:NO];
        [self.pickerView selectRow:60+self.minutes.integerValue inComponent:1 animated:NO];
        if ([self.pickerView numberOfComponents] >2) {
            [self.pickerView selectRow:60+self.seconds.integerValue inComponent:2 animated:NO];
        }
    }else {
        NSInteger hour = self.model.timer / 60 / 60;
        if (hour) {
            [self.pickerView selectRow:0 inComponent:0 animated:NO];
            self.hours = @"1";
        } else {
            self.hours = @"0";
        }
        [self.pickerView selectRow:0 inComponent:1 animated:NO];
        self.minutes = @"0";
        if ([self.pickerView numberOfComponents] >2) {
            [self.pickerView selectRow:60+self.seconds.integerValue inComponent:2 animated:NO];
        }
        self.seconds = @"0";
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (instancetype)initTimerViewWithModel:(id<TYDFTimerModelProtocol>)model {
    if (self = [super init]) {
        self.model = model;
        [self initView];
    }
    return self;
}

+ (instancetype)timerViewWithModel:(id<TYDFTimerModelProtocol>)model {
    TYDFTimerSetView *view = [[TYDFTimerSetView alloc] initTimerViewWithModel:model];
    return view;
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------

- (NSInteger)numberOfComponentsInPickerView:(TYDFTimerPickerView *)pickerView {
    return self.components;
}

- (NSInteger)hoursCount {
    NSInteger hour = self.model.timer / 60 / 60 + 1;
    return hour;
}

- (NSInteger)minutesCount {
    NSInteger hour = self.model.timer / 60 / 60 + 1;
    NSUInteger minute = (self.model.timer - (hour - 1) * 60 * 60) / 60;
    if (self.hours.integerValue == hour - 1 && minute < 60) {
        return minute + 1;
    }
    return 60;
}

- (NSInteger)secondsCount {
    NSInteger hour = self.model.timer / 60 / 60 + 1;
    NSUInteger minute = (self.model.timer - (hour - 1) * 60 * 60) / 60;
    NSUInteger seconds = self.model.timer - (hour - 1) * 60 * 60 - minute * 60;
    if (self.hours.integerValue == hour - 1 && minute == self.minutes.integerValue) {
        return seconds + 1;
    }
    return 60;
}

- (NSInteger)pickerView:(TYDFTimerPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger hour = self.model.timer / 60 / 60;
    if (hour) {
        if (component == 0) {
            return [self hoursCount];
        }
        if (component == 1) {
            return [self minutesCount];
        }
        if (component == 2) {
            return [self secondsCount];
        }
    } else {
        if (component == 0) {
            return [self minutesCount];
        }
        if (component == 1) {
            return [self secondsCount];
        }
    }
    return 0;
}

- (NSAttributedString *)pickerView:(TYDFTimerPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *string = [NSString stringWithFormat:@"%.2ld",(long)row%60];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:TYScreenAdaptor(44) weight:UIFontWeightSemibold] range:NSMakeRange(0, 2)];
    [attrString addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x22242C) range:NSMakeRange(0, 2)];
    return attrString;
}

- (void)pickerView:(TYDFTimerPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger hour = self.model.timer / 60 / 60;
    if (hour) {
        if (component == 0) {
            NSInteger minute = row%60;
            self.hours = [NSString stringWithFormat:@"%ld",minute];
            [pickerView reloadComponent:1];
        }
        if (component == 1) {
            NSInteger second = row%60;
            self.minutes = [NSString stringWithFormat:@"%ld",second];
            if (self.components == 3) {
                [pickerView reloadComponent:2];
            }
        }
        if (component == 2) {
            NSInteger second = row%60;
            self.seconds = [NSString stringWithFormat:@"%ld",second];
        }
    } else {
        if (component == 0) {
            NSInteger minute = row%60;
            self.minutes = [NSString stringWithFormat:@"%ld",minute];
            [pickerView reloadComponent:1];
        }
        if (component == 1) {
            NSInteger second = row%60;
            self.seconds = [NSString stringWithFormat:@"%ld",second];
        }
    }
    
    self.timer = [self.hours integerValue] * 60 * 60 + [self.minutes integerValue] * 60 + [self.seconds integerValue];
}


- (CGFloat)rowHeightInPickerView:(TYDFTimerPickerView *)pickerView forComponent:(NSInteger)component {
    return TYScreenAdaptor(60);
}

- (CGFloat)pickerView:(TYDFTimerPickerView *)pickerView middleTextVerticalOffsetForcomponent:(NSInteger)component {
    return TYScreenAdaptor(-3);
}

- (CGFloat)pickerView:(TYDFTimerPickerView *)pickerView middleTextHorizontalOffsetForcomponent:(NSInteger)component {
    return TYScreenAdaptor(3 + 26);
}

- (NSString *)pickerView:(TYDFTimerPickerView *)pickerView middleTextForcomponent:(NSInteger)component {
    if (self.components == 3) {
        if (component == 0) {
            return NSLocalizedString(@"scene_time_unit_minute", nil);
        }
        if (component == 1) {
            return NSLocalizedString(@"scene_time_unit_hour", nil);
        }
        if (component == 2) {
            return NSLocalizedString(@"scene_time_unit_second", nil);
        }
    } else {
        if (self.model.timerSetType == TYDFTimerSetType_Minutes) {
            if (component == 0) {
                return NSLocalizedString(@"scene_time_unit_hour", nil);
            }
            if (component == 1) {
                return NSLocalizedString(@"scene_time_unit_minute", nil);
            }
            return @"";
        } else {
            if (component == 0) {
                return NSLocalizedString(@"scene_time_unit_minute", nil);
            }
            if (component == 1) {
                return NSLocalizedString(@"scene_time_unit_second", nil);
            }
        }
    }
    return @"";
}


- (void)onClickBottomBtn {
    if (self.clickBottomBlock) {
        self.clickBottomBlock();
    }
}

#pragma mark - --------------------getters & setters & init members ------------------


//TODO: wmy 把懒加载改成以下方式

- (TYDFTimerPickerView *)timePickerView {
    TYDFTimerPickerView *timePickerView = [[TYDFTimerPickerView alloc] init];
    timePickerView.dataSource = self;
    timePickerView.delegate = self;
    timePickerView.lineHeight = 0;
    timePickerView.textFontOfSelectedRow = [UIFont systemFontOfSize:TYScreenAdaptor(44) weight:UIFontWeightSemibold];
    timePickerView.textColorOfSelectedRow = HEXCOLOR(0x22242C);
    timePickerView.textFontOfOtherRow =  [UIFont systemFontOfSize:TYScreenAdaptor(30) weight:UIFontWeightSemibold];
    timePickerView.textColorOfOtherRow = HEXCOLOR(0xDDDDDD);
    timePickerView.isCycleScroll = YES;
    timePickerView.isHiddenMiddleText = NO;
    return timePickerView;
}

TYLazyPropertyWithInit(TYDFTimerPickerView, pickerView, {
    _pickerView = [self timePickerView];
});


- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.layer.borderWidth = 1;
        _bottomBtn.layer.borderColor = HEXCOLOR(0xDDDDDD).CGColor;
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:TYScreenAdaptor(16) weight:UIFontWeightSemibold];
        [_bottomBtn addTarget:self action:@selector(onClickBottomBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

@end


