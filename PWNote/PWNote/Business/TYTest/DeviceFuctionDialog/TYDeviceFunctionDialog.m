//
//  TYDeviceFunctionDialog.m
//  TYAppleReviewModule-AppleReview
//
//  Created by mingyan on 2019/5/5.
//

#import "TYDeviceFunctionDialog.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionView.h"
#import "TYDeviceFunctionDefine.h"
#import "TYDFSliderView.h"
#import "TYDFTableViewAgency.h"
#import "TYDFTimerSetView.h"
#import "TYDFTimerView.h"
#import "TYDFCollectionTopView.h"
#import "TYDFCenterCollectionView.h"
#import "TYDFSimpleTitleLabel.h"
//TODO: wmy to delete
#import <RACEXTScope.h>

@interface TYBackView : UIView

@property (nonatomic, strong) TYDeviceFunctionView *dialogView; /**< 白色的Dialog部分,该部分在填充时，并不是添加到TYBackView中的，而是和 backView同级  */
@property (nonatomic, assign) TYDFBottomViewType bottomViewType;
//@property (nonatomic, assign) TYDeviceFunctionBgViewTopViewType topViewType;

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
        _dialogView = [[TYDeviceFunctionView alloc] initDFViewWithTopView:topView centerView:centerView];
        _dialogView.layer.cornerRadius = TYScreenAdaptor(16);
        _dialogView.userInteractionEnabled = YES;
        self.backgroundColor = HEXCOLORA(0x464646, 0.6);
    }
    return self;
}

- (void)showDialog {
    self.alpha = 0;
    CGFloat kDialogViewWidth = APP_SCREEN_WIDTH - TYScreenAdaptor(15) * 2;
    CGFloat kDialogViewHeight = TYScreenAdaptor(338);
    
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

- (void)delayDismiss {
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self dismiss];
    });
}

- (void)dismiss {
    CGFloat kDialogViewWidth = APP_SCREEN_WIDTH - TYScreenAdaptor(15) * 2;
    CGFloat kDialogViewHeight = TYScreenAdaptor(338);
    
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


@interface TYDeviceFunctionDialog ()

@end

@implementation TYDeviceFunctionDialog

+ (void)showSingleSelectFunctionDialogWithTitle:(NSString *)title
                                  selectActions:(NSArray <TYDFSingleSectionModelProtocol>*) actions
                                       callback:(SingleSelectDialogCallback)callback {
    // 头部
    TYDFSimpleTitleLabel *topView = [[TYDFSimpleTitleLabel alloc] init];
    topView.text = title;
    // 中间
    TYDFTableViewAgency *agency = [[TYDFTableViewAgency alloc] init];
    agency.actions = actions;
    UIView *centerView = agency.selectTableView;

    @weakify(agency);
    [self showDialogWithTopView:topView centerView:centerView bottomType:TYDFBottomViewType_Arrow callback:^(TYBackView *backView) {
        @strongify(agency);
        
        [agency.selectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(agency.selectTableView.superview);
        }];
        
        backView.dialogView.middleSubViewAgency = agency;
        agency.selectItemBlock = ^(id<TYDFSingleSectionModelProtocol> model,NSInteger index) {
            if (callback) {
                callback(model,index);
            }
            [backView delayDismiss];
        };
    }];
}

+ (void)showSliderFuctionDialogWithTitle:(NSString *)title
                             sliderModel:(id<TYDeviceSliderFuctionModelProtocol>)model
                                callback:(SliderDialogCallback)callback {
    // 头部
    TYDFSimpleTitleLabel *topView = [[TYDFSimpleTitleLabel alloc] init];
    topView.text = title;
    // 中间
    TYDFSliderView *view = [[TYDFSliderView alloc] initWithDeviceFunctionModel:model];
    view.block = ^(double number,UIColor *color) {
        if (callback) {
            callback(number,color);
        }
    };
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.equalTo(view.superview);
        make.height.mas_equalTo(TYScreenAdaptor(90));
        make.top.mas_equalTo(TYScreenAdaptor(80));
    }];


    [self showDialogWithTopView:topView centerView:view bottomType:TYDFBottomViewType_Arrow callback:nil];
    
    
}

+ (void)showTimerSetFunctionDialogWithTitle:(NSString *)title
                                 timerModel:(id<TYDFTimerModelProtocol>)model
                                   callback:(TimerSetDialogCallback)callback {
    // 头部
    TYDFSimpleTitleLabel *topView = [[TYDFSimpleTitleLabel alloc] init];
    topView.text = title;
    // 中间
    TYDFTimerSetView *view = [[TYDFTimerSetView alloc] initTimerViewWithModel:model];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view.superview);
        make.top.mas_equalTo(TYScreenAdaptor(10));
        make.bottom.mas_equalTo(-TYScreenAdaptor(24 + 48));
    }];

    @weakify(view);
    [self showDialogWithTopView:topView centerView:view bottomType:TYDFBottomViewType_StartButton callback:^(TYBackView *backView) {
        view.clickBottomBlock = ^{
            @strongify(view);
            if (callback) {
                callback(view.timer);
            }
            [backView dismiss];
        };
    }];
}

+ (void)showTimerFunctionDialogWithTitle:(NSString *)title
                              timerModel:(id<TYDFTimerModelProtocol>)model
                                callback:(TimerCancelDialogCallback)callback {
    // 头部
    TYDFSimpleTitleLabel *topView = [[TYDFSimpleTitleLabel alloc] init];
    topView.text = title;
    // 中间
    TYDFTimerView *view = [[TYDFTimerView alloc] initTimerViewWithModel:model];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view.superview);
        make.top.mas_equalTo(TYScreenAdaptor(120-56));
        make.bottom.mas_equalTo(TYScreenAdaptor(-48));
    }];
   
    [self showDialogWithTopView:topView centerView:view bottomType:TYDFBottomViewType_CencelButton callback:^(TYBackView *backView) {
        view.clickBottomBlock = ^{
            if (callback) {
                callback();
            }
            [backView dismiss];
        };
    }];
    
}

+ (void)showCompleteFunctionDialogWithDelegate:(id<TYDeviceFunctionDelegate>)delegate {
    TYDFCollectionTopView *topView = [[TYDFCollectionTopView alloc] init];
    topView.datas = [delegate dialogTitleDatas];
    TYDFCenterCollectionView *centerView = [[TYDFCenterCollectionView alloc] init];
    centerView.delegate = delegate;
    [self showDialogWithTopView:topView centerView:centerView bottomType:TYDFBottomViewType_Arrow callback:nil];
}

#pragma mark - private

+ (void)showDialogWithTopView:(UIView *)topView centerView:(UIView *)centerView bottomType:(TYDFBottomViewType)bottomType callback:(void(^)(TYBackView *backView))backCallBack {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (keyWindow) {
        TYBackView *backView = [[TYBackView alloc] initWithTopView:topView centerView:centerView];
        backView.bottomViewType = bottomType;
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
            backCallBack(backView);
        }
    }
}


@end
