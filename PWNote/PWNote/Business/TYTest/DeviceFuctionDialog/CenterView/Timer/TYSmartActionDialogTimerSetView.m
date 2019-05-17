//
//  TYDFTimerView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogTimerSetView.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"
#import "TYSmartActionDialogTimerPickerView.h"

@interface TYSmartActionDialogTimerSetView () <TYDFTimerPickerViewDelegate,TYDFTimerPickerViewDataSource>

@property (nonatomic, strong) TYSmartActionDialogTimerPickerView *pickerView;

@property (nonatomic, copy) NSString *hours;
@property (nonatomic, copy) NSString *minutes;
@property (nonatomic, strong) NSString *seconds;

@property (nonatomic, strong) UITableView *hourTableView;

@property (nonatomic, assign) NSInteger components;

@end


@implementation TYSmartActionDialogTimerSetView


#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)initView {
    [self addTimePicker];
    [self initPickerPosition];
}

- (void)initComponents {
    self.components = 0;
    if (self.model.timerSetType == TYSmartActionDialogTimerSetType_Seconds) {
        NSInteger hour = self.model.dialogTimer / 60 / 60;
        if (hour) {
            self.components = 3;
        } else {
            self.components = 2;
        }
    } else {
        self.components = 2;
    }
}

- (void)addTimePicker {
    if (!self.model) {
        return;
    }
    [self initComponents];
    
    [self addSubview:self.pickerView];
    if (self.components == 2) {
        [self.pickerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self).offset(-TYScreenAdaptor(24 + 48));
            make.left.mas_equalTo(TYScreenAdaptor(20));
            make.right.mas_equalTo(-TYScreenAdaptor(20));
            make.top.mas_equalTo(-TYScreenAdaptor(5));
        }];
    } else {
        [self.pickerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self).offset(-TYScreenAdaptor(24 + 48));;
            make.left.mas_equalTo(TYScreenAdaptor(10));
            make.right.mas_equalTo(-TYScreenAdaptor(10));
            make.top.mas_equalTo(-TYScreenAdaptor(5));
        }];
    }
    
}

- (void)initPickerPosition {
    if (!self.model) {
        return;
    }
    if (self.minutes && self.hours && self.seconds) {
        [self.pickerView selectRow:self.hours.integerValue inComponent:0 animated:NO];
        [self.pickerView selectRow:self.minutes.integerValue inComponent:1 animated:NO];
        if ([self.pickerView numberOfComponents] >2) {
            [self.pickerView selectRow:self.seconds.integerValue inComponent:2 animated:NO];
        }
    }else {
        NSInteger hour = self.model.dialogTimer / 60 / 60;
        if (hour) {
            [self.pickerView selectRow:0 inComponent:0 animated:NO];
            self.hours = @"1";
        } else {
            self.hours = @"0";
        }
        [self.pickerView selectRow:0 inComponent:1 animated:NO];
        self.minutes = @"0";
        if ([self.pickerView numberOfComponents] >2) {
            [self.pickerView selectRow:0 inComponent:2 animated:NO];
        }
        self.seconds = @"0";
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (instancetype)initTimerViewWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model {
    if (self = [super initTimerViewWithModel:model]) {
        self.model = model;
        [self initView];
    }
    return self;
}

+ (instancetype)timerViewWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model {
    TYSmartActionDialogTimerSetView *view = [[TYSmartActionDialogTimerSetView alloc] initTimerViewWithModel:model];
    return view;
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------

- (NSInteger)numberOfComponentsInPickerView:(TYSmartActionDialogTimerPickerView *)pickerView {
    return self.components;
}

- (NSInteger)hoursCount {
    NSInteger hour = self.model.dialogTimer / 60 / 60 + 1;
    return hour;
}

- (NSInteger)minutesCount {
    NSInteger hour = self.model.dialogTimer / 60 / 60 + 1;
    NSUInteger minute = (self.model.dialogTimer - (hour - 1) * 60 * 60) / 60;
    if (self.hours.integerValue == hour - 1 && minute < 60) {
        return minute + 1;
    }
    return 60;
}

- (NSInteger)secondsCount {
    NSInteger hour = self.model.dialogTimer / 60 / 60 + 1;
    NSUInteger minute = (self.model.dialogTimer - (hour - 1) * 60 * 60) / 60;
    NSUInteger seconds = self.model.dialogTimer - (hour - 1) * 60 * 60 - minute * 60;
    if (self.hours.integerValue == hour - 1 && minute == self.minutes.integerValue) {
        return seconds + 1;
    }
    return 60;
}

- (NSInteger)pickerView:(TYSmartActionDialogTimerPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger hour = self.model.dialogTimer / 60 / 60;
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

- (NSAttributedString *)pickerView:(TYSmartActionDialogTimerPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *string = [NSString stringWithFormat:@"%.2ld",(long)row];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:TYScreenAdaptor(44) weight:UIFontWeightSemibold] range:NSMakeRange(0, 2)];
    [attrString addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0x22242C) range:NSMakeRange(0, 2)];
    return attrString;
}

- (void)pickerView:(TYSmartActionDialogTimerPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger hour = self.model.dialogTimer / 60 / 60;
    if (hour) {
        if (component == 0) {
            NSInteger hour = row;
            if (hour == [self.hours integerValue]) {
                [pickerView reloadComponent:1];
            }
            self.hours = [NSString stringWithFormat:@"%ld",hour];
        }
        if (component == 1) {
            NSInteger minute = row;
            self.minutes = [NSString stringWithFormat:@"%ld",minute];
            if (self.components == 3) {
                [pickerView reloadComponent:2];
            }
        }
        if (component == 2) {
            NSInteger second = row;
            self.seconds = [NSString stringWithFormat:@"%ld",second];
        }
    } else {
        if (component == 0) {
            NSInteger minute = row;
            self.minutes = [NSString stringWithFormat:@"%ld",minute];
            [pickerView reloadComponent:1];
        }
        if (component == 1) {
            NSInteger second = row;
            self.seconds = [NSString stringWithFormat:@"%ld",second];
        }
    }
    
    self.timer = [self.hours integerValue] * 60 * 60 + [self.minutes integerValue] * 60 + [self.seconds integerValue];
}


- (CGFloat)rowHeightInPickerView:(TYSmartActionDialogTimerPickerView *)pickerView forComponent:(NSInteger)component {
    return TYScreenAdaptor(60);
}

- (CGFloat)pickerView:(TYSmartActionDialogTimerPickerView *)pickerView middleTextVerticalOffsetForcomponent:(NSInteger)component {
    return TYScreenAdaptor(-3);
}

- (CGFloat)pickerView:(TYSmartActionDialogTimerPickerView *)pickerView middleTextHorizontalOffsetForcomponent:(NSInteger)component {
    return TYScreenAdaptor(3 + 26);
}

- (NSString *)pickerView:(TYSmartActionDialogTimerPickerView *)pickerView middleTextForcomponent:(NSInteger)component {
    if (self.components == 3) {
        if (component == 0) {
            return NSLocalizedString(@"scene_time_unit_hour", nil);
        }
        if (component == 1) {
            return NSLocalizedString(@"scene_time_unit_minute", nil);
        }
        if (component == 2) {
            return NSLocalizedString(@"scene_time_unit_second", nil);
        }
    } else {
        if (self.model.timerSetType == TYSmartActionDialogTimerSetType_Minutes) {
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



#pragma mark - --------------------getters & setters & init members ------------------

- (void)setModel:(id<TYSmartActionDialogTimerModelProtocol>)model {
    [super setModel:model];
    [self initView];
}

//TODO: wmy 把懒加载改成以下方式

- (TYSmartActionDialogTimerPickerView *)timePickerView {
    TYSmartActionDialogTimerPickerView *timePickerView = [[TYSmartActionDialogTimerPickerView alloc] init];
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

TYLazyPropertyWithInit(TYSmartActionDialogTimerPickerView, pickerView, {
    _pickerView = [self timePickerView];
});

@end


