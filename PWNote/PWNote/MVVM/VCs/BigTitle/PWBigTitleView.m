//
//  PWBigTitleView.m
//  PWNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWBigTitleView.h"
#import <Masonry/Masonry.h>
#import "PWBigTitleViewModel.h"

@interface PWBigTitleView ()

@property (nonatomic, strong) UILabel *bigTitleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel; /**< 小标题  */

@end

@implementation PWBigTitleView

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
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bigTitleLabel];
    [self addSubview:self.subTitleLabel];
    [self.bigTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(-10);
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bigTitleLabel);
        make.bottom.equalTo(self.bigTitleLabel.mas_top);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

- (void)setViewModel:(id<PWViewModelProtocol>)viewModel {
    if ([viewModel isKindOfClass:[PWBigTitleViewModel class]]) {
        PWBigTitleViewModel *model = (PWBigTitleViewModel *)viewModel;
        self.bigTitleLabel.text = model.bigTitle;
        self.subTitleLabel.text = model.subTitle;
    }
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
        _subTitleLabel.textColor = [UIColor whiteColor];
    }
    return _subTitleLabel;
}

- (UILabel *)bigTitleLabel {
    if (!_bigTitleLabel) {
        _bigTitleLabel = [[UILabel alloc] init];
        _bigTitleLabel.font = [UIFont boldSystemFontOfSize:28];
        _bigTitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _bigTitleLabel.textColor = [UIColor whiteColor];
    }
    return _bigTitleLabel;
}

@end
