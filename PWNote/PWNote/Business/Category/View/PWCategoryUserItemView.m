//
//  PWCategoryUserView.m
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWCategoryUserItemView.h"
#import "PWCategoryUserViewModel.h"

@interface PWCategoryUserItemView ()

@property (nonatomic, strong) UIImageView *iconImageView; /**< 头像  */
@property (nonatomic, strong) UILabel *titleLabel; /**< 名称  */

@property (nonatomic, strong) UIButton *searchBtn; /**< 搜索  */

@end

@implementation PWCategoryUserItemView

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
    [self addSubview:self.iconImageView];
    self.iconImageView.layer.cornerRadius = 20;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self.mas_bottom).offset(-30);
        make.left.mas_equalTo(16);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(8);
    }];
    
    [self addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.right.mas_equalTo(-8);
        make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

#pragma mark - --------------------private methods--------------

- (void)setViewModel:(id<PWViewModelProtocol>)viewModel {
    if ([viewModel isKindOfClass:[PWCategoryUserViewModel class]]) {
        PWCategoryUserViewModel *model = (PWCategoryUserViewModel *)viewModel;
        self.titleLabel.text = model.userName;
        [self.iconImageView pw_setImageViewWithUrlString:model.iconImageUrl];
    }
}

- (void)onClickSearch {
    if (self.searchBlock) {
        self.searchBlock();
    }
}

#pragma mark - --------------------getters & setters & init members ------------------

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.titleLabel.font = [AMIconfont fontWithSize:24];
        [_searchBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        [_searchBtn setTitle:XIconSearch forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(onClickSearch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kTitleColor;
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}

@end
