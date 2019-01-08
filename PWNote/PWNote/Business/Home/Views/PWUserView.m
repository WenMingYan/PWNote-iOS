//
//  PWUserView.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWUserView.h"
#import <Masonry/Masonry.h>
#import "UIView+ALMAdditons.h"
#import "AMIconfont.h"
#import "PWSkinManager.h"

@interface PWUserView ()

@property (nonatomic, strong) UIImageView *userIconImageView; /**< 用户头像  */
@property (nonatomic, strong) UILabel *defaultLabel;

@end

@implementation PWUserView

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
    [self addSubview:self.userIconImageView];
    [self.userIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(56);
        make.center.equalTo(self);
    }];
    [self addSubview:self.defaultLabel];
    [self.defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (instancetype)initWithSuperView:(UIView *)superView {
    PWUserView *userView = [[PWUserView alloc] init];
    [superView addSubview:userView];
    [userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(60);
        make.bottom.mas_equalTo((-16 - kSafeArea_Bottom));
        make.right.mas_equalTo(-16);
    }];
    return userView;
}
#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    self.userIconImageView.layer.cornerRadius = self.userIconImageView.bounds.size.width * 0.5;
    
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------
- (UILabel *)defaultLabel {
    if (!_defaultLabel) {
        _defaultLabel = [[UILabel alloc] init];
        _defaultLabel.textColor = kThemeColor;
        _defaultLabel.font = [AMIconfont fontWithSize:32];
        _defaultLabel.text = XIconSmile;
    }
    return _defaultLabel;
}
- (UIImageView *)userIconImageView {
    if (!_userIconImageView) {
        _userIconImageView = [[UIImageView alloc] init];
        _userIconImageView.backgroundColor = kLightSubTitleColor;
    }
    return _userIconImageView;
}

@end
