//
//  TYDeviceFunctionDialog.m
//  TYAppleReviewModule-AppleReview
//
//  Created by mingyan on 2019/5/5.
//

#import "TYSmartActionDialog.h"
#import <Masonry/Masonry.h>
#import "TYActionDialogView.h"
#import "TYDeviceFunctionDefine.h"
#import "TYSmartActionDialogNumericSliderView.h"
#import "TYSmartActionDialogPaletteSliderView.h"
#import "TYSmartActionDialogTableViewAgency.h"
#import "TYSmartActionDialogTimerSetView.h"
#import "TYSmartActionDialogTimerView.h"
#import "TYSmartActionDialogCollectionTopView.h"
#import "TYSmartActionDialogCenterCollectionView.h"
#import "TYSmartActionDialogSimpleTitleLabel.h"
#import "TYSmartActionDialogColoursSaturabilitySliderView.h"
#import "TYSmartActionDialogColoursSaturabilityIntensitySliderView.h"
//TODO: wmy to delete
#import <RACEXTScope.h>


// 设定时间回调
typedef void (^TimerSetDialogCallback)(NSTimeInterval timer);
// 取消设定回调
typedef void (^TimerCancelDialogCallback)(void);

@interface TYBackView : UIView

@property (nonatomic, strong) TYActionDialogView *dialogView; /**< 白色的Dialog部分,该部分在填充时，并不是添加到TYBackView中的，而是和 backView同级  */
@property (nonatomic, assign) BOOL hiddenBottomArrow;
//@property (nonatomic, assign) TYDeviceFunctionBgViewTopViewType topViewType;
@property (nonatomic, assign) CGFloat dialogHeight;

@end

@implementation TYBackView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = HEXCOLORA(0x464646,0.6);
        UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                    action:@selector(dismiss)];
        [self addGestureRecognizer:dismissTap];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (instancetype)initWithTopView:(UIView *)topView centerView:(UIView *)centerView {
    if (self = [super init]) {
        _dialogView = [[TYActionDialogView alloc] initDFViewWithTopView:topView centerView:centerView];
        _dialogView.layer.cornerRadius = TYScreenAdaptor(16);
        _dialogView.clipsToBounds = YES;
        _dialogView.userInteractionEnabled = YES;
        self.backgroundColor = HEXCOLORA(0x464646, 0.6);
        UITapGestureRecognizer *selfTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(dismiss)];
        [self addGestureRecognizer:selfTap];
    }
    return self;
}

- (void)showDialog {
    self.alpha = 0;
    CGFloat kDialogViewWidth = APP_SCREEN_WIDTH - TYScreenAdaptor(15) * 2;
    CGFloat kDialogViewHeight = self.dialogHeight;
    
    CGRect frame = CGRectMake(TYScreenAdaptor(15),
                              APP_SCREEN_HEIGHT - kDialogViewHeight - (TYScreenAdaptor(15 + (APP_TAB_BAR_HEIGHT - 49))),
                              kDialogViewWidth, kDialogViewHeight);
    
    self.dialogView.frame = CGRectMake(TYScreenAdaptor(15),
                                       APP_SCREEN_HEIGHT,
                                       kDialogViewWidth, kDialogViewHeight);
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1;
        self.dialogView.frame = frame;
    } completion:^(BOOL finished) {
        NSLog(@"");
    }];
}

- (void)setHiddenBottomArrow:(BOOL)hiddenBottomArrow {
    _hiddenBottomArrow = hiddenBottomArrow;
    self.dialogView.hiddenBottomArrow = hiddenBottomArrow;
}

- (void)delayDismiss {
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self dismiss];
    });
}

- (void)dismiss {
    CGFloat kDialogViewWidth = APP_SCREEN_WIDTH - TYScreenAdaptor(15) * 2;
    CGFloat kDialogViewHeight = self.dialogHeight;
    
    CGRect frame = CGRectMake(TYScreenAdaptor(15),
                              APP_SCREEN_HEIGHT,
                              kDialogViewWidth, kDialogViewHeight);
    
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0;
        self.dialogView.frame = frame;
    } completion:^(BOOL finished) {
        [self.dialogView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end


@interface TYSmartActionDialog ()

@end

@implementation TYSmartActionDialog


/**
 根据Model实现的Delegate方法，显示Dialog
 //TODO: wmy 待测试
 */
+ (void)showDialogWithModel:(id<TYSmartActionDialogModelProtocol>)model
                andDelegate:(id<TYSmartActionDialogEventDelegate>)eventDelegate {
    // 单选
    if ([model conformsToProtocol:@protocol(TYSmartActionDialogSelectorModelProtocol)] &&
        [eventDelegate conformsToProtocol:@protocol(TYSmartActionDialogEventDelegate)]) {
        [self showSelectorDialogWithModel:(id<TYSmartActionDialogSelectorModelProtocol>)model
                              andDelegate:(id<TYDFSelectorEventDelegate>)eventDelegate];
    }
    // 数字滑块
    else if ([model conformsToProtocol:@protocol(TYSmartActionDialogNumberModelProtocol)] &&
             [eventDelegate conformsToProtocol:@protocol(TYDFNumberSliderEventDelegate)]) {
        [self showSliderNumberDialogWithModel:(id<TYSmartActionDialogNumberModelProtocol>)model
                                  andDelegate:(id<TYDFNumberSliderEventDelegate>)eventDelegate];
    }
    // 色彩滑块
    else if ([model conformsToProtocol:@protocol(TYSmartActionDialogColoursModelProtocol)] &&
             [eventDelegate conformsToProtocol:@protocol(TYDFColoursSliderEventDelegate)]) {
        [self showSliderColoursDialogWithModel:(id<TYSmartActionDialogColoursModelProtocol>)model
                                   andDelegate:(id<TYDFColoursSliderEventDelegate>)eventDelegate];
    }
    // 显示【色彩、饱和度】滑块选项框
    else if ([model conformsToProtocol:@protocol(TYDDFSliderColoursSaturabilityModelProtocol)] &&
             [eventDelegate conformsToProtocol:@protocol(TYDFColoursSaturabilitySliderEventDelegate)]) {
        [self showColoursSaturabilitySliderDialogWithModel:(id<TYDDFSliderColoursSaturabilityModelProtocol>)model
                                               andDelegate:(id<TYDFColoursSaturabilitySliderEventDelegate>)eventDelegate];
    }
    // 显示【色彩、饱和度】滑块选项框
    else if ([model conformsToProtocol:@protocol(TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol)] &&
             [eventDelegate conformsToProtocol:@protocol(TYDFColoursSaturabilityIntensitySliderEventDelegate)]) {
        [self showColoursSaturabilityIntensitySliderDialogWithModel:(id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>)model
                                                        andDelegate:(id<TYDFColoursSaturabilityIntensitySliderEventDelegate>)eventDelegate];
    }
    // 定时
    else if ([model conformsToProtocol:@protocol(TYSmartActionDialogTimerModelProtocol)] &&
             [eventDelegate conformsToProtocol:@protocol(TYDFTimerDialogEventDelegate)]) {
        [self showTimerFunctionDialogWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model
                                   andDelegate:(id<TYDFTimerDialogEventDelegate>)eventDelegate];
    }
    
}



/**
 根据传入的Models显示复杂的Dialog
 */
+ (void)showDialogWithModels:(NSArray<id<TYSmartActionDialogModelProtocol>> *)models
                 andDelegate:(id<TYDFCompleteDialogEventDelegate>)eventDelegate {
    // 头部
    TYSmartActionDialogCollectionTopView *topView = [[TYSmartActionDialogCollectionTopView alloc] init];
    topView.models = models;
    // 中间
    TYSmartActionDialogCenterCollectionView *centerView = [[TYSmartActionDialogCenterCollectionView alloc] init];
    centerView.models = models;
    centerView.delegate = eventDelegate;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (keyWindow) {
        TYBackView *backView = [[TYBackView alloc] initWithTopView:topView centerView:centerView];
        backView.dialogView.topViewHeight = TYScreenAdaptor(78);
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topView.superview);
            make.left.mas_equalTo(topView.superview);
            make.right.mas_equalTo(topView.superview);
            make.width.mas_lessThanOrEqualTo(topView.superview);
            make.height.mas_equalTo(TYScreenAdaptor(78));
        }];
        
        [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(centerView.superview);
            make.bottom.mas_equalTo(-TYScreenAdaptor(-12));
        }];
        backView.dialogHeight = TYScreenAdaptor(359);
        @weakify(backView);
        @weakify(centerView);
        topView.clickBlock = ^(NSInteger index, id<TYSmartActionDialogModelProtocol>  _Nonnull model) {
            @strongify(centerView);
            @strongify(backView);
            [centerView selectIndex:index];
            if ([model conformsToProtocol:@protocol(TYSmartActionDialogTimerModelProtocol)]) {
                backView.hiddenBottomArrow = YES;
            } else {
                backView.hiddenBottomArrow = NO;
            }
        };
        [keyWindow addSubview:backView];
        [keyWindow addSubview:backView.dialogView];
        
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(keyWindow);
        }];
        
        [backView showDialog];
        backView.dialogView.clickDismissBlock = ^{
            @strongify(backView);
            [backView dismiss];
        };
    }
    
}

#pragma mark - ----------------- 单选接口 -----------------

+ (void)showSelectorDialogWithModel:(id<TYSmartActionDialogSelectorModelProtocol>)model
                           callback:(SingleSelectDialogCallback)callback {
    // 中间
    TYSmartActionDialogTableViewAgency *agency = [[TYSmartActionDialogTableViewAgency alloc] init];
    agency.actions = model.dialogOptions;
    agency.selectIndex = model.originalSelectIndex;
    
    @weakify(agency);
    [self showDialogWithTopView:[self configSimpleLabelWithText:model.dialogTitle]
                     centerView:agency.selectTableView
              hiddenBottomArrow:NO
                       callback:^(TYBackView *backView, UIView *topView, UIView *centerView) {
                           @strongify(agency);
                           [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
                               make.edges.equalTo(centerView.superview);
                           }];
                           
                           backView.dialogView.middleSubViewAgency = agency;
                           agency.selectItemBlock = ^(NSInteger index) {
                               if (callback) {
                                   callback(index);
                               }
                               [backView delayDismiss];
                           };
                           [topView mas_makeConstraints:^(MASConstraintMaker *make) {
                               make.top.mas_equalTo(topView.superview);
                               make.left.mas_equalTo(topView.superview).offset(TYScreenAdaptor(15));
                               make.right.mas_equalTo(topView.superview).offset(TYScreenAdaptor(-15));
                               make.width.mas_lessThanOrEqualTo(topView.superview).offset(TYScreenAdaptor(-30));
                               make.height.mas_equalTo(TYScreenAdaptor(56));
                           }];
                       }];
}

+ (void)showSelectorDialogWithModel:(id<TYSmartActionDialogSelectorModelProtocol>)model
                        andDelegate:(id<TYDFSelectorEventDelegate>)delegate {
    [self showSelectorDialogWithModel:model callback:^(NSInteger index) {
        if ([delegate respondsToSelector:@selector(dialogSelectIndex:)]) {
            [delegate dialogSelectIndex:index];
        }
    }];
}

#pragma mark - ----------------- 滑块接口 -----------------
#pragma mark 显示数字滑块选项框
/**
 显示数字滑块选项框
 温度、亮度、饱和度选项可以使用该方法创建
 */
+ (void)showSliderNumberDialogWithModel:(id<TYSmartActionDialogNumberModelProtocol>)model
                            andDelegate:(id<TYDFNumberSliderEventDelegate>)delegate {
    [self showSliderNumberDialogWithModel:model callback:^(double number1) {
        if ([delegate respondsToSelector:@selector(dialogSliderWithValue:)]) {
            [delegate dialogSliderWithValue:number1];
        }
    }];
}
+ (void)showSliderNumberDialogWithModel:(id<TYSmartActionDialogNumberModelProtocol>)model
                               callback:(SliderDialogNumCallback)callback {
    // 中间
    TYSmartActionDialogNumericSliderView *view = [[TYSmartActionDialogNumericSliderView alloc] initWithDeviceFunctionModel:model];
    
    view.block = ^(double number) {
        if (callback) {
            callback(number);
        }
    };
    [self showDialogWithTopView:[self configSimpleLabelWithText:model.dialogTitle]
                     centerView:view
              hiddenBottomArrow:NO
                       callback:^(TYBackView *backView, UIView *topView, UIView *centerView) {
                           [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
                               make.left.right.width.equalTo(centerView.superview);
                               make.height.mas_equalTo(TYScreenAdaptor(90));
                               make.top.mas_equalTo(TYScreenAdaptor(80));
                           }];
                           [topView mas_makeConstraints:^(MASConstraintMaker *make) {
                               make.top.mas_equalTo(topView.superview);
                               make.left.mas_equalTo(topView.superview).offset(TYScreenAdaptor(15));
                               make.right.mas_equalTo(topView.superview).offset(TYScreenAdaptor(-15));
                               make.width.mas_lessThanOrEqualTo(topView.superview).offset(TYScreenAdaptor(-30));
                               make.height.mas_equalTo(TYScreenAdaptor(56));
                           }];
    }];
    
}

#pragma mark 显示彩色滑块选项框
/**
 显示彩色滑块选项框
 */
+ (void)showSliderColoursDialogWithModel:(id<TYSmartActionDialogColoursModelProtocol>)model
                             andDelegate:(id<TYDFColoursSliderEventDelegate>)delegate {
    [self showSliderColoursDialogWithModel:model callback:^(double number,UIColor *color) {
        if ([delegate respondsToSelector:@selector(dialogSliderInNumber:andColor:)]) {
            [delegate dialogSliderWithNumber:number andColor:color];
        }
    }];
}
+ (void)showSliderColoursDialogWithModel:(id<TYSmartActionDialogColoursModelProtocol>)model
                                callback:(SliderDialogColoursCallback)callback {
    // 中间
    TYSmartActionDialogPaletteSliderView *view = [[TYSmartActionDialogPaletteSliderView alloc] initWithDeviceFunctionModel:model];
    view.block = ^(double number, UIColor *colorBlock) {
        if (callback) {
            callback(number,colorBlock);
        }
    };

    [self showDialogWithTopView:[self configSimpleLabelWithText:model.dialogTitle]
                     centerView:view
              hiddenBottomArrow:NO
                       callback:^(TYBackView *backView, UIView *topView, UIView *centerView) {
                           [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
                               make.left.right.width.equalTo(centerView.superview);
                               make.height.mas_equalTo(TYScreenAdaptor(90));
                               make.top.mas_equalTo(TYScreenAdaptor(80));
                           }];
                           [topView mas_makeConstraints:^(MASConstraintMaker *make) {
                               make.top.mas_equalTo(topView.superview);
                               make.left.mas_equalTo(topView.superview).offset(TYScreenAdaptor(15));
                               make.right.mas_equalTo(topView.superview).offset(TYScreenAdaptor(-15));
                               make.width.mas_lessThanOrEqualTo(topView.superview).offset(TYScreenAdaptor(-30));
                               make.height.mas_equalTo(TYScreenAdaptor(56));
                           }];
                       }];
}

#pragma mark 显示【色彩、饱和度】滑块选项框
/**
 显示【色彩、饱和度】滑块选项框
 */
+ (void)showColoursSaturabilitySliderDialogWithModel:(id<TYDDFSliderColoursSaturabilityModelProtocol>)model
                                             andDelegate:(id<TYDFColoursSaturabilitySliderEventDelegate>)delegate {
    [self showColoursSaturabilitySliderDialogWithModel:model andColoursCallback:^(double number, UIColor *color) {
        if ([delegate respondsToSelector:@selector(dialogSliderWithNumber:andColor:)]) {
            [delegate dialogSliderWithNumber:number andColor:color];
        }
    } andSaturabilityCallback:^(double number1) {
        if ([delegate respondsToSelector:@selector(dialogSaturabilitySliderWithNumber:)]) {
            [delegate dialogSaturabilitySliderWithNumber:number1];
        }
    }];
}

+ (void)showColoursSaturabilitySliderDialogWithModel:(id<TYDDFSliderColoursSaturabilityModelProtocol>)model
                                  andColoursCallback:(SliderDialogColoursCallback)sCallback
                             andSaturabilityCallback:(SliderDialogNumCallback)tCallback {
    // 中间
    TYSmartActionDialogColoursSaturabilitySliderView *view = [[TYSmartActionDialogColoursSaturabilitySliderView alloc] initSilderViewWithModel:model];
    view.saturabilityCallback = tCallback;
    view.coloursCallback = sCallback;
    [self showDialogWithTopView:[self configSimpleLabelWithText:model.dialogTitle]
                     centerView:view
              hiddenBottomArrow:NO
                       callback:^(TYBackView *backView, UIView *topView, UIView *centerView) {
                           [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
                               make.edges.equalTo(centerView.superview);
                           }];
                           [topView mas_makeConstraints:^(MASConstraintMaker *make) {
                               make.top.mas_equalTo(topView.superview);
                               make.left.mas_equalTo(topView.superview).offset(TYScreenAdaptor(15));
                               make.right.mas_equalTo(topView.superview).offset(TYScreenAdaptor(-15));
                               make.width.mas_lessThanOrEqualTo(topView.superview).offset(TYScreenAdaptor(-30));
                               make.height.mas_equalTo(TYScreenAdaptor(56));
                           }];
                       }];
}

#pragma mark 显示【色彩、饱和度、亮度】滑块选项框
/**
 显示【色彩、饱和度、亮度】滑块选项框
 */
+ (void)showColoursSaturabilityIntensitySliderDialogWithModel:(id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>)model
                                                  andDelegate:(id<TYDFColoursSaturabilityIntensitySliderEventDelegate>)delegate {
    [self showColoursSaturabilityIntensitySliderDialogWithModel:model andColoursCallback:^(double number, UIColor *color) {
        if ([delegate respondsToSelector:@selector(dialogSliderWithNumber:andColor:)]) {
            [delegate dialogSliderWithNumber:number andColor:color];
        }
    } andSaturabilityCallback:^(double number1) {
        if ([delegate respondsToSelector:@selector(dialogSaturabilitySliderWithNumber:)]) {
            [delegate dialogSaturabilitySliderWithNumber:number1];
        }
    } andIntensityCallback:^(double number1) {
        if ([delegate respondsToSelector:@selector(dialogIntensitySliderWithNumber:)]) {
            [delegate dialogIntensitySliderWithNumber:number1];
        }
    }];
}

+ (void)showColoursSaturabilityIntensitySliderDialogWithModel:(id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>)model
                                           andColoursCallback:(SliderDialogColoursCallback)cCallback
                                      andSaturabilityCallback:(SliderDialogNumCallback)sCallback
                                         andIntensityCallback:(SliderDialogNumCallback)iCallback {
    TYSmartActionDialogColoursSaturabilityIntensitySliderView *view = [[TYSmartActionDialogColoursSaturabilityIntensitySliderView alloc] initSliderViewWithModel:model];
    view.coloursCallback = cCallback;
    view.saturabilityCallback = sCallback;
    view.intensityCallback = iCallback;
    [self showDialogWithTopView:[self configSimpleLabelWithText:model.dialogTitle]
                     centerView:view
                   dialogHeight:TYScreenAdaptor(366)
              hiddenBottomArrow:NO
                       callback:^(TYBackView *backView, UIView *topView, UIView *centerView) {
                           [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
                               make.edges.equalTo(centerView.superview);
                           }];
                           [topView mas_makeConstraints:^(MASConstraintMaker *make) {
                               make.top.mas_equalTo(topView.superview);
                               make.left.mas_equalTo(topView.superview).offset(TYScreenAdaptor(15));
                               make.right.mas_equalTo(topView.superview).offset(TYScreenAdaptor(-15));
                               make.width.mas_lessThanOrEqualTo(topView.superview).offset(TYScreenAdaptor(-30));
                               make.height.mas_equalTo(TYScreenAdaptor(56));
                           }];
                       }];
}

#pragma mark - ----------------- 定时接口 -----------------

+ (void)showTimerFunctionDialogWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model
                             andDelegate:(id<TYDFTimerDialogEventDelegate>)delegate {
    [self showTimerFunctionDialogWithModel:model callback:^(NSTimeInterval timer){
        if ([delegate respondsToSelector:@selector(dialogDidClickWithTimer:)]) {
            [delegate dialogDidClickWithTimer:timer];
        }
    }];
}
+ (void)showTimerFunctionDialogWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model
                                callback:(TimerDialogClickCallback)callback {
    // 中间
    TYSmartActionDialogTimerBaseView *view;
    if (model.hasSetTimer) {
        view = [[TYSmartActionDialogTimerView alloc] initTimerViewWithModel:model];
    } else {
        view = [[TYSmartActionDialogTimerSetView alloc] initTimerViewWithModel:model];
    }
    @weakify(view);
    [self showDialogWithTopView:[self configSimpleLabelWithText:model.dialogTitle]
                     centerView:view
              hiddenBottomArrow:YES
                       callback:^(TYBackView *backView,UIView *topView,UIView *centerView) {
                           @strongify(view);
                           @weakify(view);
                           view.clickBottomBlock = ^{
                               @strongify(view);
                               if (callback) {
                                   callback(view.timer);
                               }
                               [backView dismiss];
                           };
                           [topView mas_makeConstraints:^(MASConstraintMaker *make) {
                               make.top.mas_equalTo(topView.superview);
                               make.left.mas_equalTo(topView.superview).offset(TYScreenAdaptor(15));
                               make.right.mas_equalTo(topView.superview).offset(TYScreenAdaptor(-15));
                               make.width.mas_lessThanOrEqualTo(topView.superview).offset(TYScreenAdaptor(-30));
                               make.height.mas_equalTo(TYScreenAdaptor(56));
                           }];
                           if (model.hasSetTimer) {
                               [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
                                   make.left.right.equalTo(view.superview);
                                   make.top.mas_equalTo(TYScreenAdaptor(120-56));
                                   make.bottom.mas_equalTo(centerView.superview);
                               }];
                           } else {
                               [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
                                   make.left.right.equalTo(centerView.superview);
                                   make.top.mas_equalTo(TYScreenAdaptor(10));
                                   make.bottom.mas_equalTo(centerView.superview);
                               }];
                           }
                           
                       }];
    
}

#pragma mark - private

+ (TYSmartActionDialogSimpleTitleLabel *)configSimpleLabelWithText:(NSString *)text {
    TYSmartActionDialogSimpleTitleLabel *label = [TYSmartActionDialogSimpleTitleLabel simpleTitleView];
    label.text = text;
    return label;
}

+ (void)showDialogWithTopView:(UIView *)topView
                   centerView:(UIView *)centerView
                 dialogHeight:(CGFloat)dialogHeight
            hiddenBottomArrow:(BOOL)hiddenBottomArrow
                     callback:(void(^)(TYBackView *backView,UIView *topView,UIView *centerView))backCallBack {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (keyWindow) {
        TYBackView *backView = [[TYBackView alloc] initWithTopView:topView centerView:centerView];
        backView.dialogHeight = dialogHeight;
        backView.hiddenBottomArrow = hiddenBottomArrow;
        [keyWindow addSubview:backView];
        [keyWindow addSubview:backView.dialogView];
        
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(keyWindow);
        }];
        
        [backView showDialog];
        @weakify(backView);
        backView.dialogView.clickDismissBlock = ^{
            @strongify(backView);
            [backView dismiss];
        };
        
        if (backCallBack) {
            backCallBack(backView,topView,centerView);
        }
    }
}

+ (void)showDialogWithTopView:(UIView *)topView
                   centerView:(UIView *)centerView
            hiddenBottomArrow:(BOOL)hiddenBottomArrow
                     callback:(void(^)(TYBackView *backView,UIView *topView,UIView *centerView))backCallBack {
    [self showDialogWithTopView:topView
                     centerView:centerView
                   dialogHeight:TYScreenAdaptor(338)
              hiddenBottomArrow:hiddenBottomArrow
                       callback:backCallBack];
}


@end
