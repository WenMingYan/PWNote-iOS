//
//  PWCategoryItemView.m
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWCategoryItemView.h"
#import "PWCategoryViewModel.h"

@interface PWCategoryItemView ()

@property (nonatomic, strong) UILabel *titleLabel; /**< 标题  */
@property (nonatomic, strong) UILabel *iconLabel; /**< icon  */
@property (nonatomic, strong) UILabel *numberLabel; /**< 数字  */

@end

@implementation PWCategoryItemView

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
    [self addSubview:self.iconLabel];
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(16);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconLabel.mas_right).offset(8);
        make.centerY.mas_equalTo(self);
    }];
    
    [self addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-16);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

#pragma mark - --------------------getters & setters & init members ------------------

- (void)setViewModel:(id<PWViewModelProtocol>)viewModel {
    if ([viewModel isKindOfClass:[PWCategoryViewModel class]]) {
        PWCategoryViewModel *model = (PWCategoryViewModel *)viewModel;
        self.titleLabel.text = model.title;
        self.numberLabel.text = model.number;
        self.iconLabel.textColor = model.iconColor;
    }
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont systemFontOfSize:12];
        _numberLabel.textColor = kTitleColor;
    }
    return _numberLabel;
}

- (UILabel *)iconLabel {
    if (!_iconLabel) {
        _iconLabel = [[UILabel alloc] init];
        _iconLabel.textColor = kThemeColor;
        _iconLabel.font = [UIFont systemFontOfSize:16];
#if DEBUG
        _iconLabel.layer.borderWidth = 1;
        _iconLabel.layer.borderColor = [UIColor redColor].CGColor;
#endif
    }
    return _iconLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kTitleColor;
    }
    return _titleLabel;
}

@end
