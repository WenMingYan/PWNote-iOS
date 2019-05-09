//
//  TYDFTimerView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYDFTimerView.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"

@interface TYDFTimerView ()

@property (nonatomic, strong) id<TYDFTimerModelProtocol> model; /**< 数据 */

@property (nonatomic, strong) UILabel *timerLabel; /**< 显示时间  */
@property (nonatomic, strong) dispatch_source_t flushTimer;
@property (nonatomic, strong) UIButton *bottomBtn; /**< 底部按钮  */

@end

@implementation TYDFTimerView


#pragma mark - --------------------dealloc ------------------

- (void)dealloc {
    dispatch_source_cancel(self.flushTimer);
    _flushTimer = nil;
}

#pragma mark - --------------------life cycle--------------------

- (void)flushTime {
    __block int timeout = self.model.timer; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.flushTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.flushTimer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(self.flushTimer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(self.flushTimer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
            });
        }else{
            int hours = timeout / 60 / 60;
            int minutes = (timeout - hours * 60 * 60) / 60;
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.timerLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
            });
            timeout--;
        }
    });
    dispatch_resume(self.flushTimer);
}

- (void)initView {
    [self addSubview:self.timerLabel];
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(TYScreenAdaptor(70));
        
        
    }];
    [self flushTime];
    self.bottomBtn.layer.cornerRadius = TYScreenAdaptor(26);
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(TYScreenAdaptor(160));
        make.height.mas_equalTo(TYScreenAdaptor(48));
        make.bottom.mas_offset(self);
        make.centerX.mas_equalTo(self);
    }];
    self.bottomBtn.backgroundColor = HEXCOLOR(0xF8443B);
    [_bottomBtn setTitleColor:HEXCOLOR(0xFFFFFF) forState:UIControlStateNormal];
    
    [self.bottomBtn setTitle:NSLocalizedString(@"action_cancel", nil) forState:UIControlStateNormal];
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
    TYDFTimerView *view = [[TYDFTimerView alloc] initTimerViewWithModel:model];
    return view;
}

#pragma mark - --------------------Event Response--------------

- (void)onClickBottomBtn {
    if (self.clickBottomBlock) {
        self.clickBottomBlock();
    }
}

#pragma mark - --------------------getters & setters & init members ------------------

- (UILabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc] init];
        _timerLabel.textColor = HEXCOLOR(0x22242C);
        _timerLabel.font = [UIFont systemFontOfSize:TYScreenAdaptor(50)];
    }
    return _timerLabel;
}

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
