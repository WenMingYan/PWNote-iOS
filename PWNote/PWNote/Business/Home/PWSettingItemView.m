//
//  PWSettingItemView.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWSettingItemView.h"
#import "PWSettingViewModel.h"

@interface PWSettingItemView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation PWSettingItemView

#pragma mark - --------------------dealloc ------------------
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
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.centerY.equalTo(self);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}
#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

- (void)setViewModel:(id<PWViewModelProtocol>)model {
    [super setViewModel:model];
    if ([model isKindOfClass:[PWSettingViewModel class]]) {
        PWSettingViewModel *viewModel = (PWSettingViewModel *)model;
        self.titleLabel.text = viewModel.title;
    }
}

- (void)onSelected {
    PWSettingViewModel *viewModel = (PWSettingViewModel *)self.viewModel;
    if (viewModel.clickBlock) {
        viewModel.clickBlock();
    }
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

@end
