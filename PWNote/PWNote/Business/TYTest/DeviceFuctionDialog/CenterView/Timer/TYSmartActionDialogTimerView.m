//
//  TYDFTimerView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogTimerView.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"
//TODO: wmy to delete
#import <RACEXTScope.h>

@interface TYSmartActionDialogTimerView ()

@property (nonatomic, strong) UILabel *timerLabel; /**< 显示时间  */
@property (nonatomic, strong) dispatch_source_t flushTimer;

@end

@implementation TYSmartActionDialogTimerView


#pragma mark - --------------------dealloc ------------------

- (void)dealloc {
    dispatch_source_cancel(self.flushTimer);
    _flushTimer = nil;
}

#pragma mark - --------------------life cycle--------------------


- (instancetype)initTimerViewWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model {
    if (self = [super initTimerViewWithModel:model]) {
        self.model = model;
        [self initView];
    }
    return self;
}

+ (instancetype)timerViewWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model {
    TYSmartActionDialogTimerView *view = [[TYSmartActionDialogTimerView alloc] initTimerViewWithModel:model];
    return view;
}


- (void)flushTime {
    __block int timeout = self.model.dialogTimer; //倒计时时间
    if (!timeout) {
        return;
    }
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
            @weakify(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self);
                //设置界面的按钮显示 根据自己需求设置
                self.timerLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
                self.timer = timeout;
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
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}
#pragma mark - --------------------getters & setters & init members ------------------

- (void)setModel:(id<TYSmartActionDialogTimerModelProtocol>)model {
    [super setModel:model];
//    dispatch_source_cancel(self.flushTimer);
//    _flushTimer = nil;
    [self flushTime];
}

- (UILabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc] init];
        _timerLabel.textColor = HEXCOLOR(0x22242C);
        _timerLabel.font = [UIFont systemFontOfSize:TYScreenAdaptor(50)];
    }
    return _timerLabel;
}

@end
