//
//  TYDeviceFunctionBgView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYActionDialogView.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"
#import "TYSmartActionDialogSingleTableViewCell.h"
#import "TYSmartActionDialogCollectionTopView.h"

@interface TYActionDialogView ()

@property (nonatomic, strong) UIView *topView; /**< 顶部  */
@property (nonatomic, strong) UIView *middleView; /**< 中间展现部分  */

//TODO: wmy 这里需要将上中下三层抽取出来
@property (nonatomic, strong) UIImageView *downArrowImageView; /**< 箭头  */
@property (nonatomic, strong) UIView *downView; /**< 点击底部  */

@end

@implementation TYActionDialogView

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

- (void)setTopViewHeight:(double)topViewHeight {
    _topViewHeight = topViewHeight;
    if (!_topViewHeight) {
        _topViewHeight = TYScreenAdaptor(56);
    }
    [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(self.topViewHeight);
    }];
    self.topView.backgroundColor = [UIColor whiteColor];
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    double topViewHeight = self.topViewHeight;
    if (!topViewHeight) {
        topViewHeight = TYScreenAdaptor(56);
    }
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(topViewHeight);
    }];

    
    CALayer *layer = [self.topView layer];
    layer.shadowOffset = CGSizeMake(0, 1); //(0,0)时是四周都有阴影
    layer.shadowRadius = 4.0;
    layer.shadowOpacity = 0.1;
    layer.shadowColor = HEXCOLOR(0x2B2B2B).CGColor;
    
    
    [self addSubview:self.middleView];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self).offset(TYScreenAdaptor(-28));
    }];
    
    [self addSubview:self.downArrowImageView];
    [self.downArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(TYScreenAdaptor(-12));
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(TYScreenAdaptor(12));
        make.height.mas_equalTo(TYScreenAdaptor(5));
    }];
    
    [self addSubview:self.downView];
    [self.downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.bottom.mas_equalTo(self);
        make.height.mas_equalTo(TYScreenAdaptor(40));
    }];


    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

+ (instancetype)dialogFunctionViewWithTopView:(UIView *)topView
                                   centerView:(UIView *)centerView {
    TYActionDialogView *view = [[TYActionDialogView alloc] initDFViewWithTopView:topView centerView:centerView];
    
    return view;
}

- (instancetype)initDFViewWithTopView:(UIView *)topView
                           centerView:(UIView *)centerView {
    if (self = [super init]) {
        [self.topView addSubview:topView];
        [self.middleView addSubview:centerView];
    }
    return self;
}

#pragma mark - --------------------Event Response--------------

- (void)onClickDown {
    if (self.clickDismissBlock) {
        self.clickDismissBlock();
    }
}

#pragma mark - --------------------getters & setters & init members ------------------

- (void)setHiddenBottomArrow:(BOOL)hiddenBottomArrow {
    _hiddenBottomArrow = hiddenBottomArrow;
    self.downView.hidden = hiddenBottomArrow;
    self.downArrowImageView.hidden = hiddenBottomArrow;
}

- (UIView *)downView {
    if (!_downView) {
        _downView = [[UIView alloc] init];
        UITapGestureRecognizer *downTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(onClickDown)];
        [_downView addGestureRecognizer:downTap];
    }
    return _downView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
    }
    return _topView;
}

- (UIImageView *)downArrowImageView {
    if (!_downArrowImageView) {
        _downArrowImageView = [[UIImageView alloc] init];
        _downArrowImageView.image = [UIImage imageNamed:@"ty_device_function_downarrow"];
    }
    return _downArrowImageView;
}

- (UIView *)middleView {
    if (!_middleView) {
        _middleView = [[UIView alloc] init];
    }
    return _middleView;
}

@end
