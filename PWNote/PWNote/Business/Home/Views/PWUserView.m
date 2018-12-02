//
//  PWUserView.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWUserView.h"
#import <Masonry/Masonry.h>

@interface PWUserView ()

@property (nonatomic, strong) UIImageView *userIconImageView; /**< 用户头像  */

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
#if DEBUG
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor redColor].CGColor;
#endif
    [self addSubview:self.userIconImageView];
    [self.userIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(58);
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
        make.bottom.mas_equalTo(-16);
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

- (UIImageView *)userIconImageView {
    if (!_userIconImageView) {
        _userIconImageView = [[UIImageView alloc] init];
    }
    return _userIconImageView;
}

@end
