//
//  TYDeviceFunctionBgView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYDeviceFunctionView.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"
#import "TYDeviceFunctionSingleTableViewCell.h"
#import "TYDFCollectionTopView.h"

@interface TYDeviceFunctionView ()

@property (nonatomic, strong) UIView *topView; /**< 顶部  */
@property (nonatomic, strong) UIView *middleView; /**< 中间展现部分  */

@property (nonatomic, strong) UIImageView *downArrowImageView; /**< 箭头  */
@property (nonatomic, strong) UIView *downView; /**< 点击底部  */

@end

@implementation TYDeviceFunctionView

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
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(TYScreenAdaptor(56));
    }];
    
//    [self.topView addSubview:self.titleLabel];
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.topView);
//        make.width.mas_lessThanOrEqualTo(self.topView).offset(TYScreenAdaptor(-30));
//    }];
//
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
        make.height.mas_equalTo(40);
    }];

#if DEBUG
    self.downView.layer.borderWidth = 1;
    self.downView.layer.borderColor = [UIColor redColor].CGColor;
#endif
    
    [self addSubview:self.middleView];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self).offset(TYScreenAdaptor(-28));
    }];

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

+ (instancetype)dialogFunctionViewWithTopView:(UIView *)topView
                                   centerView:(UIView *)centerView {
    TYDeviceFunctionView *view = [[TYDeviceFunctionView alloc] initDFViewWithTopView:topView centerView:centerView];
    
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

- (void)setBottomViewType:(TYDFBottomViewType)bottomViewType {
    _bottomViewType = bottomViewType;
    switch (bottomViewType) {
        case TYDFBottomViewType_Arrow: {
            self.downArrowImageView.hidden = NO;
            self.downView.hidden = NO;
        }
            break;
        case TYDFBottomViewType_StartButton: {
            self.downArrowImageView.hidden = YES;
            self.downView.hidden = YES;

            
            
        }
            break;
        case TYDFBottomViewType_CencelButton: {
            self.downArrowImageView.hidden = YES;
            self.downView.hidden = YES;
            
        }
            break;
            
        default:
            break;
    }
}
//
//- (void)setTopViewType:(TYDeviceFunctionBgViewTopViewType)topViewType {
//    _topViewType = topViewType;
//    switch (topViewType) {
//        case TYDeviceFunctionBgViewTopViewType_Classical: {
//            [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(self);
//                make.left.mas_equalTo(self);
//                make.right.mas_equalTo(self);
//                make.height.mas_equalTo(TYScreenAdaptor(56));
//            }];
//        }
//            break;
//        case TYDeviceFunctionBgViewTopViewType_Custom: {
//            [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(self);
//                make.left.mas_equalTo(self);
//                make.right.mas_equalTo(self);
//                make.height.mas_equalTo(TYScreenAdaptor(78));
//            }];
//        }
//            break;
//        default:
//            break;
//    }
//}

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
