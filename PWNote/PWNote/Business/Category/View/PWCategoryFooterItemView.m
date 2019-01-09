//
//  PWCategoryFooterItemView.m
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWCategoryFooterItemView.h"
#import "PWCagegoryFooterViewModel.h"

@interface PWCategoryFooterItemView ()

@property (nonatomic, strong) UILabel *iconLabel; /**< 添加icon  */
@property (nonatomic, strong) UILabel *titleLabel; /**< 添加清单  */

@end

@implementation PWCategoryFooterItemView

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
    [self addSubview:self.titleLabel];
    
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.centerY.equalTo(self).mas_offset(-kSafeArea_Bottom);
        make.left.mas_equalTo(kMargin);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconLabel.mas_centerY);
        make.left.mas_equalTo(self.iconLabel.mas_right).mas_offset(8);
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)setViewModel:(id<PWViewModelProtocol>)viewModel {
    [super setViewModel:viewModel];
    if ([viewModel isKindOfClass:[PWCagegoryFooterViewModel class]]) {
        PWCagegoryFooterViewModel *model = (PWCagegoryFooterViewModel *)viewModel;
        self.titleLabel.text = model.title;
    }
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UILabel *)iconLabel {
    if (!_iconLabel) {
        _iconLabel = [[UILabel alloc] init];
        _iconLabel.font = [AMIconfont fontWithSize:24];
        _iconLabel.text = XIconAdd;
        _iconLabel.textColor = kThemeColor;
    }
    return _iconLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kThemeColor;
    }
    return _titleLabel;
}

@end
