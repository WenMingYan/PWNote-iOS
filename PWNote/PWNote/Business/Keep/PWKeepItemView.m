//
//  PWKeepItemView.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWKeepItemView.h"
#import "PWKeepViewModel.h"

@interface PWKeepItemView ()

@property (nonatomic, strong) UILabel *titleLabel; /**< 标题  */
@property (nonatomic, strong) UILabel *contentLabel; /**< 内容  */

@end

@implementation PWKeepItemView


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
    [self addSubview:self.contentLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(kMargin / 2);
        make.width.lessThanOrEqualTo(self).mas_offset(-kMargin * 2);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kMargin / 2);
        make.width.lessThanOrEqualTo(self).mas_offset(-kMargin * 2);
        make.bottom.mas_equalTo(self).mas_offset(-kMargin / 2);
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
    if ([model isKindOfClass:[PWKeepViewModel class]]) {
        PWKeepViewModel *viewModel = (PWKeepViewModel *)model;
        self.titleLabel.text = viewModel.title;
        self.contentLabel.text = viewModel.content;
    }
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kSubTitleColor;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 4;
    }
    return _contentLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

@end
