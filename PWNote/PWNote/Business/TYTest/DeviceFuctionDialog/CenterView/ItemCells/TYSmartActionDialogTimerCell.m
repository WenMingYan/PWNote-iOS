//
//  TYDFTimerCell.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogTimerCell.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"
#import "TYSmartActionDialogTimerView.h"

@interface TYSmartActionDialogTimerCell ()

@property (nonatomic, strong) TYSmartActionDialogTimerView *timerView;

@end

@implementation TYSmartActionDialogTimerCell

#pragma mark - --------------------life cycle--------------------
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    _timerView = [[TYSmartActionDialogTimerView alloc] initTimerViewWithModel:self.model];
    [self addSubview:_timerView];
    [_timerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.mas_equalTo(TYScreenAdaptor(120-78));
        make.bottom.mas_equalTo(self);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

#pragma mark - --------------------getters & setters & init members ------------------

- (void)setModel:(id<TYSmartActionDialogTimerModelProtocol>)model {
    _model = model;
    self.timerView.model = model;
}

@end
