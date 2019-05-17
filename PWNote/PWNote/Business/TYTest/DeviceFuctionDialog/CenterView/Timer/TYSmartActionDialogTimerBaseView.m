//
//  TYDFTimerBaseView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/10.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogTimerBaseView.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"

@interface TYSmartActionDialogTimerBaseView ()

@property (nonatomic, strong) UIButton *bottomBtn; /**< 底部按钮  */

@end

@implementation TYSmartActionDialogTimerBaseView


#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initBaseView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initBaseView];
    }
    return self;
}

- (void)initBaseView {
    [self addSubview:self.bottomBtn];
    self.bottomBtn.layer.cornerRadius = TYScreenAdaptor(26);
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(TYScreenAdaptor(160));
        make.height.mas_equalTo(TYScreenAdaptor(48));
        make.bottom.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
    }];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initBaseView];
}


- (instancetype)initTimerViewWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model {
    if (self = [super init]) {
        self.model = model;
        [self initBaseView];
    }
    return self;
}

+ (instancetype)timerViewWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model {
    return [[self alloc] initTimerViewWithModel:model];
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

- (void)onClickBottomBtn {
    if (self.clickBottomBlock) {
        self.clickBottomBlock();
    }
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (void)setModel:(id<TYSmartActionDialogTimerModelProtocol>)model {
    _model = model;
    if (!model) {
        return;
    }
    if (_model.hasSetTimer) {
        self.bottomBtn.backgroundColor = HEXCOLOR(0xF8443B);
        [self.bottomBtn setTitleColor:HEXCOLOR(0xFFFFFF) forState:UIControlStateNormal];
        [self.bottomBtn setTitle:NSLocalizedString(@"action_cancel", nil) forState:UIControlStateNormal];
    } else {
        self.bottomBtn.backgroundColor = [UIColor clearColor];
        [self.bottomBtn setTitleColor:HEXCOLOR(0x495054) forState:UIControlStateNormal];
        //TODO: wmy 目前没有start的国际化
        [self.bottomBtn setTitle:NSLocalizedString(@"action_start", nil) forState:UIControlStateNormal];
    }
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
