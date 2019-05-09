//
//  TYAlertView.m
//  Pods
//
//  Created by Lucca on 2019/2/20.
//
//
//#import "TPUtils.h"
//#import "TPViewUtil.h"
#import "TYAlertView.h"
//#import "TPViewConstants.h"
//TODO: wmy to delete
#import "TYDeviceFunctionDefine.h"
#import "TYAlertShadowView.h"
#import "TYAlertViewWindow.h"
//#import "UIView+TPAdditions.h"
//TODO: wmy to delete
#import "UIView+ALMAdditons.h"

#import "TYAlertViewTextField.h"
#import "TYAlertViewController.h"
#import "TYAlertViewWindowObserver.h"

CGFloat const TYAlertViewPaddingWidth = 20.0;
CGFloat const LTYlertViewPaddingHeight = 8.0;

@interface TYAlertAction()

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL noneFont;

@end

@implementation TYAlertAction

- (instancetype)init {
    if (self = [super init]) {
        self.title = NSLocalizedString(@"done", nil);
        self.noneFont = YES;
        self.titleColor = HEXCOLOR(0x22242c);
        self.titleFont = [UIFont systemFontOfSize:16];
        self.textAligment = NSTextAlignmentCenter;
        self.backgroundColorHighlighted = HEXCOLOR(0xe5e5e5);
        self.isCancel = NO;
    }
    return self;
}

- (void)setIsCancel:(BOOL)isCancel {
    if (self.noneFont) {
        self.titleFont = isCancel ? [UIFont systemFontOfSize:16.f weight:UIFontWeightSemibold] : [UIFont systemFontOfSize:16];
    }
    _isCancel = isCancel;
}

+ (TYAlertAction *)actionWithTitle:(NSString *)title alertAciton:(AlertAtcion)action {
    return [self actionWithTitle:title color:nil font:nil alertAciton:action];
}


+ (TYAlertAction *)actionWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font alertAciton:(AlertAtcion)action {
    TYAlertAction *alertAction = [[TYAlertAction alloc] init];
    alertAction.title = title;
    if (color) {
        alertAction.titleColor = color;
    }
    if (font) {
        alertAction.titleFont = font;
    }
    alertAction.alertAction = action;
    return alertAction;
}


+ (TYAlertAction *)actionWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
             titleColorHighlighted:(UIColor *)titleColorHighlighted
                   backgroundColor:(UIColor *)backgroundColor
        backgroundColorHighlighted:(UIColor *)backgroundColorHighlighted
                              font:(UIFont *)font
                       alertAciton:(AlertAtcion)action
                      textAligment:(NSTextAlignment)textAligment
                          isCancel:(BOOL)isCancel {
    
    TYAlertAction *alertAction = [[TYAlertAction alloc] init];
    alertAction.title = title;
    alertAction.alertAction = action;
    alertAction.textAligment = textAligment;
    alertAction.isCancel = isCancel;
    
    if (titleColor) {
        alertAction.titleColor = titleColor;
    }
    
    alertAction.noneFont = YES;
    if (font) {
        alertAction.noneFont = NO;
        alertAction.titleFont = font;
    } else if (isCancel) {
        alertAction.titleFont = [UIFont systemFontOfSize:16.f weight:UIFontWeightSemibold];
    }
    
    if (backgroundColor) {
        alertAction.backgroundColor = backgroundColor;
    }
    
    if (backgroundColorHighlighted) {
        alertAction.backgroundColorHighlighted = backgroundColorHighlighted;
    }
    
    if (titleColorHighlighted) {
        alertAction.titleColorHighlighted = titleColorHighlighted;
    }
    
    return alertAction;
}

@end

typedef enum : NSUInteger {
    TYAlertViewTypeDefault,
    TYAlertViewTypeTextField,
    TYAlertViewTypeProgressView
} TYAlertViewType;


@interface TYAlertView() <UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (readwrite) BOOL             showing;
@property (readwrite) TYAlertViewStyle style;

@property (readwrite) NSString         *title;
@property (readwrite) NSString         *message;
@property (readwrite) UIView           *innerView;
@property (readwrite) NSArray          *buttonTitles;
@property (readwrite) NSString         *cancelButtonTitle;
@property (readwrite) NSArray          *textFieldsArray;

@property (nonatomic, strong) UIView   *view;
@property (nonatomic, assign) BOOL     initialized;
@property (nonatomic, assign) CGFloat  buttonHeight;
@property (nonatomic, assign) BOOL     isShowInView;

@property (nonatomic, assign) CGFloat  maxHeight;
@property (nonatomic, assign) CGFloat  headerHeight;
@property (assign, nonatomic) CGPoint  scrollViewCenterShowed;
@property (assign, nonatomic) CGPoint  scrollViewCenterHidden;

@property (assign, nonatomic) CGPoint  cancelButtonCenterShowed;
@property (assign, nonatomic) CGPoint  cancelButtonCenterHidden;

@property (nonatomic, assign) TYAlertViewType  type;
@property (assign, nonatomic, getter=isExists) BOOL exists;

@property (nonatomic, assign) CGFloat          keyboardHeight;
@property (nonatomic, assign) CGFloat          cancelButtonOffsetY;

@property (strong, nonatomic) UILabel          *titleLabel;
@property (strong, nonatomic) UILabel          *messageLabel;
@property (strong, nonatomic) UIView           *innerContainerView;

@property (strong, nonatomic) UIProgressView   *progressView;
@property (strong, nonatomic) UILabel          *progressLabel;

@property (nonatomic, strong) UIButton         *cancelButton;

@property (strong, nonatomic) TYAlertShadowView     *shadowCancelView;
@property (strong, nonatomic) UIVisualEffectView    *blurCancelView;

@property (nonatomic, strong) TYAlertShadowView     *shadowView;
@property (strong, nonatomic) UIVisualEffectView    *backgroundView;

@property (nonatomic, strong) TYAlertViewController *viewController;

@property (nonatomic, strong) NSMutableArray     *actions;
@property (nonatomic, strong) UIView             *contentView;

@property (nonatomic, strong) UIScrollView       *contentScrollView;
@property (nonatomic, strong) UIScrollView       *buttonScrollView;

@property (nonatomic, strong) UIView             *blurContentView;
@property (nonatomic, strong) UIVisualEffectView *blurView;


@property (nonatomic, assign) NSUInteger         numberOfTextFields;
@property (nonatomic, strong) TYAlertAction      *cancelAction;
@property (nonatomic, strong) TYAlertViewWindow  *alertWindow;


@property (nonatomic, copy) TYAlertViewActionHandler          actionHandler;
@property (nonatomic, copy) TYAlertViewTextFieldsSetupHandler textFieldsSetupHandler;

@end


@implementation TYAlertView


- (nonnull instancetype)initSimpleAlertWithTitle:(NSString *)title
                                         message:(NSString *)message
                                           style:(TYAlertViewStyle)style {
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.style = style;
        self.type = TYAlertViewTypeDefault;
        
        [self initDefaultPropertys];
    }
    return self;
}
- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                                style:(TYAlertViewStyle)style
                         buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                        actionHandler:(TYAlertViewActionHandler)actionHandler {
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.style = style;
        self.type = TYAlertViewTypeDefault;
        self.buttonTitles = buttonTitles;
        self.actionHandler = actionHandler;
        self.cancelButtonTitle = cancelButtonTitle;
        
        [self initDefaultPropertys];
    }
    return self;
}



- (nonnull instancetype)initWithViewAndTitle:(nullable NSString *)title
                                     message:(nullable NSString *)message
                                        view:(nullable UIView *)view
                                       style:(TYAlertViewStyle)style
                                buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                           cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                               actionHandler:(TYAlertViewActionHandler)actionHandler {
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.style = style;
        self.type = TYAlertViewTypeDefault;
        self.innerView = view;
        self.buttonTitles = buttonTitles;
        self.actionHandler = actionHandler;
        self.cancelButtonTitle = cancelButtonTitle;
        
        [self initDefaultPropertys];
    }
    return self;
}


- (nonnull instancetype)initWithTextFieldAndTitle:(nullable NSString *)title
                                          message:(nullable NSString *)message
                                numberOfTextField:(NSInteger)numberOfTextFields
                           textFieldsSetupHandler:(TYAlertViewTextFieldsSetupHandler)textFieldsSetupHandler
                                     buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                                cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                    actionHandler:(TYAlertViewActionHandler)actionHandler {
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.numberOfTextFields = numberOfTextFields;
        self.style = TYAlertViewStyleAlert;
        self.type = TYAlertViewTypeTextField;
        self.textFieldsSetupHandler = textFieldsSetupHandler;
        self.buttonTitles = buttonTitles;
        self.actionHandler = actionHandler;
        self.cancelButtonTitle = cancelButtonTitle;
        
        [self initDefaultPropertys];
    }
    return self;
}

- (nonnull instancetype)initWithProgressViewAndTitle:(nullable NSString *)title
                                             message:(nullable NSString *)message
                                            progress:(float)progress
                                   progressLabelText:(nullable NSString *)progressLabelText
                                               style:(TYAlertViewStyle)style
                                        buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                                   cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                       actionHandler:(TYAlertViewActionHandler)actionHandler {
    if (self = [super init]) {
        self.title = title;
        self.message = message;
        self.style = TYAlertViewStyleAlert;
        self.type = TYAlertViewTypeTextField;
        self.buttonTitles = buttonTitles;
        self.actionHandler = actionHandler;
        self.cancelButtonTitle = cancelButtonTitle;
        
        [self initDefaultPropertys];
    }
    return self;
}


+ (nonnull instancetype)showSimpleAlertViewWithTitle:(nullable NSString *)title
                                             message:(nullable NSString *)message
                                               style:(TYAlertViewStyle)style
                                         cancelTitle:(nullable NSString *)cancelTitle {
    TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:title message:message style:style buttonTitles:nil cancelButtonTitle:cancelTitle actionHandler:nil];
    [alertView showAnimated];
    return alertView;
}


+ (nonnull instancetype)showTextFieldAlertViewWithTitle:(nullable NSString *)title
                                                message:(nullable NSString *)message
                                      numberOfTextField:(NSInteger)numberOfTextFields
                                 textFieldsSetupHandler:(TYAlertViewTextFieldsSetupHandler)textFieldsSetupHandler
                                           buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                                      cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                          actionHandler:(TYAlertViewActionHandler)actionHandler {
    TYAlertView *alertView = [[TYAlertView alloc] initWithTextFieldAndTitle:title message:message numberOfTextField:numberOfTextFields textFieldsSetupHandler:textFieldsSetupHandler buttonTitles:buttonTitles cancelButtonTitle:cancelButtonTitle actionHandler:actionHandler];
    [alertView showAnimated];
    return alertView;
}

+ (nonnull instancetype)showAlertViewWithTitle:(nullable NSString *)title
                                       message:(nullable NSString *)message
                                          view:(nullable UIView *)view
                                         style:(TYAlertViewStyle)style
                                  buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                 actionHandler:(TYAlertViewActionHandler)actionHandler {
    TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:title message:message style:style buttonTitles:buttonTitles cancelButtonTitle:cancelButtonTitle actionHandler:actionHandler];
    [alertView showAnimated];
    return alertView;
}


+ (nonnull instancetype)showProgressAlertViewWithTitle:(nullable NSString *)title
                                               message:(nullable NSString *)message
                                              progress:(float)progress
                                     progressLabelText:(nullable NSString *)progressLabelText
                                                 style:(TYAlertViewStyle)style
                                          buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                                     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                         actionHandler:(TYAlertViewActionHandler)actionHandler {
    TYAlertView *alertView = [[TYAlertView alloc] initWithProgressViewAndTitle:title message:message progress:progress progressLabelText:progressLabelText style:style buttonTitles:buttonTitles cancelButtonTitle:cancelButtonTitle actionHandler:actionHandler];
    [alertView showAnimated];
    return alertView;
}


#pragma mark - init default property
- (void)initDefaultPropertys {
    _dismissOnAction = YES;
    _cancelOnTouch = self.style == TYAlertViewStyleActionSheet;
    _coverColor = [UIColor colorWithWhite:0.0 alpha:0.35];
    _coverBlurEffect = nil;
    _coverAlpha = 1.0;
    _backgroundColor = UIColor.whiteColor;
    _backgroundBlurEffect = nil;
    _width = 0;
    _shouldDismissAnimated = YES;
    _buttonHeight = 50.f;
    _cancelButtonOffsetY = 10.0;
    if (@available(iOS 11.0, *)) {
        CGFloat bottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
        self.cancelButtonOffsetY = bottom > 0 ? bottom : 8.0;
    }
    _layerCornerRadius = 12.0;
    _layerBorderColor = nil;
    _layerBorderWidth = 0.0;
    _layerShadowColor = nil;
    _layerShadowRadius = 0.0;
    _layerShadowOffset = CGPointZero;
    
    _titleTextColor = nil;
    _titleTextAlignment = NSTextAlignmentCenter;
    _titleFont = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];;
    _tintColor = HEXCOLOR(0xff4800);
    
    _messageTextColor = HEXCOLOR(0x81828B);
    _messageTextAlignment = NSTextAlignmentCenter;
    _messageFont = [UIFont systemFontOfSize:14];
    _messageLineSpacing = 3.f;
    _seperateLineBetweenTitleAndMessage = NO;
    
    _progressViewTrackTintColor = HEXCOLOR(0xf5a62);
    _progressViewProgressImage = nil;
    _progressViewTrackImage = nil;
    
    _progressLabelTextColor = UIColor.blackColor;
    _progressLabelTextAlignment = NSTextAlignmentCenter;
    _progressLabelFont = [UIFont systemFontOfSize:14.0];
    _progressLabelNumberOfLines = 1;
    _progressLabelLineBreakMode = NSLineBreakByTruncatingTail;
    
    _textFieldsBackgroundColor = [UIColor clearColor];
    _textFieldsTextColor = HEXCOLOR(0x22242c);
    _textFieldsFont = [UIFont systemFontOfSize:14.0];
    _textFieldsTextAlignment = NSTextAlignmentLeft;
    _textFieldsClearsOnBeginEditing = NO;
    _textFieldsAdjustsFontSizeToFitWidth = NO;
    _textFieldsMinimumFontSize = 12.0;
    _textFieldsClearButtonMode = UITextFieldViewModeAlways;
    
    self.view = [UIView new];
    self.view.backgroundColor = UIColor.clearColor;
    self.view.userInteractionEnabled = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.backgroundView = [[UIVisualEffectView alloc] initWithEffect:self.coverBlurEffect];
    self.backgroundView.alpha = 0.0;
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.backgroundView];
    
    // -----
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction:)];
    tapGesture.delegate = self;
    [self.backgroundView addGestureRecognizer:tapGesture];
    
    // -----
    
    self.viewController = [[TYAlertViewController alloc] initWithAlertView:self view:self.view];
    
    self.alertWindow = [[TYAlertViewWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.alertWindow.hidden = YES;
    self.alertWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.alertWindow.opaque = NO;
    self.alertWindow.backgroundColor = UIColor.clearColor;
    self.alertWindow.rootViewController = self.viewController;
    
    [self initTitleActions];
    
    // -----
    self.initialized = YES;
}

- (void)initTitleActions {
    
    self.actions = [@[] mutableCopy];
    NSInteger index = self.cancelButtonTitle ? 1 : 0;
    
    [self.buttonTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TYAlertAction *action = [TYAlertAction actionWithTitle:obj titleColor:nil titleColorHighlighted:nil backgroundColor:nil backgroundColorHighlighted:nil font:nil alertAciton:nil textAligment:NSTextAlignmentCenter isCancel:NO];
        action.index = idx + index;
        [self.actions addObject:action];
    }];
    
    if (self.cancelButtonTitle) {
        UIFont *cancelFont = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
        TYAlertAction *cancelAction = [TYAlertAction actionWithTitle:self.cancelButtonTitle titleColor:HEXCOLOR(0x22242c) titleColorHighlighted:nil backgroundColor:nil backgroundColorHighlighted:nil font:cancelFont alertAciton:nil textAligment:NSTextAlignmentCenter isCancel:YES];
        cancelAction.index = 0;
        cancelAction.isCancel = YES;
        if (self.cancelButtonOffsetY != 0 && self.style == TYAlertViewStyleActionSheet) {
            self.cancelAction = cancelAction;
        } else {
            if (self.actions.count < 2) {
                [self.actions insertObject:cancelAction atIndex:0];
            } else {
                [self.actions addObject:cancelAction];
            }
        }
    }
}

#pragma mark - Keyboard notifications

- (void)keyboardVisibleChanged:(NSNotification *)notification {
    if (!self.isShowing || self.alertWindow.isHidden || !self.alertWindow.isKeyWindow) return;
    
    NSDictionary *notificationUserInfo = notification.userInfo;
    CGFloat keyboardHeight = (notificationUserInfo[UIKeyboardFrameEndUserInfoKey] ? CGRectGetHeight([notificationUserInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]) : 0.0);
    
    if (!keyboardHeight) return;
    
    NSTimeInterval animationDuration = [notificationUserInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    int animationCurve = [notificationUserInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        self.keyboardHeight = keyboardHeight;
    }
    else {
        self.keyboardHeight = 0.0;
    }
    [self layoutViewsWithSize:self.view.bounds.size];
    
    [UIView commitAnimations];
}

- (void)keyboardFrameChanged:(NSNotification *)notification {
    if (!self.isShowing ||
        self.alertWindow.isHidden ||
        !self.alertWindow.isKeyWindow ||
        [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] != 0.0) {
        return;
    }
    
    self.keyboardHeight = CGRectGetHeight([notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]);
}

#pragma mark - Window notifications

- (void)windowVisibleChanged:(NSNotification *)notification {
    if (notification.object == self.alertWindow) {
        [self.viewController.view setNeedsLayout];
    }
}


#pragma mark - Observers

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardVisibleChanged:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardVisibleChanged:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowVisibleChanged:) name:UIWindowDidBecomeVisibleNotification object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeVisibleNotification object:nil];
}


#pragma mark - Class load

+ (void)load {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        [[TYAlertViewWindowObserver sharedInstance] startObserving];
    });
}

#pragma mark - Dealloc

- (void)dealloc {
    [self removeObservers];
}

#pragma mark - Show

- (void)showAnimated:(BOOL)animated completionHandler:(TYAlertHandler)completionHandler {
    [self showAnimated:animated view:nil completionHandler:completionHandler];
}

- (void)showAnimated {
    [self showAnimated:YES completionHandler:nil];
}

- (void)show {
    [self showAnimated:YES completionHandler:nil];
}

- (void)showInView:(UIView *)view {
    [self showAnimated:YES view:view completionHandler:nil];
}

- (void)showAnimated:(BOOL)animated view:(UIView *)view completionHandler:(TYAlertHandler)completionHandler {
    if (!self.initialized || self.isShowing) return;
    self.alertWindow.windowLevel = UIWindowLevelStatusBar + 1;
    [self setupViewsWithSize:CGSizeZero];
    [self layoutViewsWithSize:CGSizeZero];
    
    self.showing = YES;
    
    if (!view) {
        self.view.userInteractionEnabled = NO;
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (keyWindow != [TYAlertView appWindow]) {
            keyWindow.hidden = YES;
        }
        
        [self.alertWindow makeKeyAndVisible];
    } else {
        self.isShowInView = YES;
        [view addSubview:self.view];
    }
    
    [self addObservers];
    
    if (self.willShowHandler) {
        self.willShowHandler(self);
    }
    
    if (animated) {
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:1.0
              initialSpringVelocity:0.5
                            options:0
                         animations:^{
                             [self animationViews];
                         } completion:^(BOOL finished) {
                             
                             if (self.type == TYAlertViewTypeTextField && self.textFieldsArray.count) {
                                 [self.textFieldsArray[0] becomeFirstResponder];
                             }
                             self.view.userInteractionEnabled = YES;
                             
                             if (completionHandler) {
                                 completionHandler();
                             }
                             
                             if (self.didShowHandler) {
                                 self.didShowHandler(self);
                             }
                         }];
    }
    
}


- (void)animationViews {
    self.backgroundView.alpha = self.coverAlpha;
    
    if (self.style == TYAlertViewStyleAlert) {
        self.contentView.transform = CGAffineTransformIdentity;
        self.contentView.alpha = 1.0;
        
        self.shadowView.transform = CGAffineTransformIdentity;
        self.shadowView.alpha = 1.0;
        
        self.blurView.transform = CGAffineTransformIdentity;
        self.blurView.alpha = 1.0;
    }
    else {
        self.contentView.center = self.scrollViewCenterShowed;
        
        self.shadowView.center = self.scrollViewCenterShowed;
        
        self.blurView.center = self.scrollViewCenterShowed;
    }
    
    if (self.isCancelButtonSperateWithSelf && self.cancelButton) {
        self.cancelButton.center = self.cancelButtonCenterShowed;
        
        self.shadowCancelView.center = self.cancelButtonCenterShowed;
        
        self.blurCancelView.center = self.cancelButtonCenterShowed;
    }
}

#pragma mark - dismiss

- (void)dismissAnimated:(BOOL)animated completionHandler:(TYAlertHandler)completionHandler {
    if (!self.isShowing) return;
    
    self.view.userInteractionEnabled = NO;
    
    self.showing = NO;
    
    [self.view endEditing:YES];
    
    if (self.willDismissHandler) {
        self.willDismissHandler(self);
    }
    
    if (animated) {
        
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:1.0
              initialSpringVelocity:0.5
                            options:0
                         animations:^{
                             [self dismissAnimationView];
                         } completion:^(BOOL finished) {
                             [self dismissComplete];
                             
                             if (completionHandler) {
                                 completionHandler();
                             }
                         }];
    }
    else {
        [self dismissAnimationView];
        [self dismissComplete];
        
        if (completionHandler) {
            completionHandler();
        }
    }
}

- (void)dismissAnimated {
    [self dismissAnimated:YES completionHandler:nil];
}

- (void)dismiss {
    [self dismissAnimated:NO completionHandler:nil];
}


- (void)dismissComplete {
    [self removeObservers];
    
    self.alertWindow.hidden = YES;
    
    if (self.didDismissHandler) {
        self.didDismissHandler(self);
    }
    // -----
    if (self.isShowInView) {
        [self.view removeFromSuperview];
    }
    
    self.view = nil;
    self.viewController = nil;
    self.alertWindow = nil;
}

- (void)dismissAnimationView {
    self.backgroundView.alpha = 0.0;
    
    if (self.style == TYAlertViewStyleAlert) {
        CGAffineTransform transform = CGAffineTransformMakeScale(0.9, 0.9);
        CGFloat alpha = 0.0;
        
        self.contentView.transform = transform;
        self.contentView.alpha = alpha;
        
        self.shadowView.transform = transform;
        self.shadowView.alpha = alpha;
        
        self.blurView.transform = transform;
        self.blurView.alpha = alpha;
    }
    else {
        self.contentView.center = self.scrollViewCenterHidden;
        
        self.shadowView.center = self.scrollViewCenterHidden;
        
        self.blurView.center = self.scrollViewCenterHidden;
    }
    
    if ([self isCancelButtonSperateWithSelf] && self.cancelButton) {
        self.cancelButton.center = self.cancelButtonCenterHidden;
        
        self.shadowCancelView.center = self.cancelButtonCenterHidden;
        
        self.blurCancelView.center = self.cancelButtonCenterHidden;
    }
}

#pragma mark - layout views


- (void)setupViewsWithSize:(CGSize)size {
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = self.viewController.view.bounds.size;
    }
    
    CGFloat width = self.width;
    
    if (!self.isExists) {
        self.exists = YES;
        
        [self addBackgroundView];
        [self addShadowView];
        [self addBlurView];
        [self addContentView];
        [self addContentScrollView];
        [self addButtonScrollView];
        CGFloat contentOffsetY = 0.0;
        
        
        if (self.title.length > 0) {
            self.titleLabel = [UILabel new];
            self.titleLabel.text = self.title;
            self.titleLabel.textColor = self.titleTextColor;
            self.titleLabel.textAlignment = self.titleTextAlignment;
            self.titleLabel.numberOfLines = 5;
            self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.titleLabel.backgroundColor = UIColor.clearColor;
            self.titleLabel.font = self.titleFont;
            
            CGSize titleLabelSize = [self.titleLabel sizeThatFits:CGSizeMake(width - TYAlertViewPaddingWidth * 2.0, CGFLOAT_MAX)];
            CGRect titleLabelFrame = CGRectMake(TYAlertViewPaddingWidth, self.innerMarginHeight, width - TYAlertViewPaddingWidth * 2.0, titleLabelSize.height);
            
            self.titleLabel.frame = titleLabelFrame;
            [self.contentScrollView addSubview:self.titleLabel];
            
            contentOffsetY = CGRectGetMinY(self.titleLabel.frame) + CGRectGetHeight(self.titleLabel.frame);
        }
        
        if (self.title && self.message && self.seperateLineBetweenTitleAndMessage) {
            UILabel *lineLabel = [self getLineLabelWithOffset:contentOffsetY];
            [self.contentScrollView addSubview:lineLabel];
            contentOffsetY += CGRectGetHeight(lineLabel.frame);
        }
        
        if (self.message.length > 0) {
            self.messageLabel = [UILabel new];
            NSMutableParagraphStyle *stringStyle = [[NSMutableParagraphStyle alloc] init];
            stringStyle.lineSpacing = self.messageLineSpacing;
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.message attributes:@{NSParagraphStyleAttributeName: stringStyle}];
            self.messageLabel.attributedText = attributedString;
            self.messageLabel.textColor = self.messageTextColor;
            self.messageLabel.numberOfLines = 0;
            self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.messageLabel.backgroundColor = UIColor.clearColor;
            self.messageLabel.font = self.messageFont;
            
            if (self.messageTextAlignment != NSTextAlignmentCenter) {
                self.messageLabel.textAlignment = self.messageTextAlignment;
            } else {
                CGFloat messageWidth = [self.message boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.messageFont} context:nil].size.width;
                if (messageWidth / width > 3) {
                    self.messageLabel.textAlignment = NSTextAlignmentJustified;
                } else {
                    self.messageLabel.textAlignment = NSTextAlignmentCenter;
                }
            }

            
            if (!contentOffsetY) {
                contentOffsetY = self.innerMarginHeight / 2.0;
            }
            else if (self.style == TYAlertViewStyleActionSheet) {
                contentOffsetY -= self.innerMarginHeight / 3.0;
            }
            
            CGSize messageLabelSize = [self.messageLabel sizeThatFits:CGSizeMake(width - TYAlertViewPaddingWidth * 2.0, CGFLOAT_MAX)];
            CGRect messageLabelFrame = CGRectMake(TYAlertViewPaddingWidth, contentOffsetY + self.innerMarginHeight / 2.0, width-TYAlertViewPaddingWidth * 2.0, messageLabelSize.height);
            
            
            self.messageLabel.frame = messageLabelFrame;
            [self.contentScrollView addSubview:self.messageLabel];
            
            contentOffsetY = CGRectGetMinY(self.messageLabel.frame) + CGRectGetHeight(self.messageLabel.frame);
        }
        
        if (self.innerView) {
            self.innerContainerView = [UIView new];
            self.innerContainerView.backgroundColor = UIColor.clearColor;
            CGSize size = [self.innerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            self.innerView.size = size;
            
            CGRect innerContainerViewFrame = CGRectMake(0.0, contentOffsetY + self.innerMarginHeight, width, CGRectGetHeight(self.innerView.bounds));
            
            self.innerContainerView.frame = innerContainerViewFrame;
            [self.contentScrollView addSubview:self.innerContainerView];
            
            CGRect innerViewFrame = CGRectMake((width / 2.0) - (CGRectGetWidth(self.innerView.bounds) / 2.0),
                                               0.0,
                                               CGRectGetWidth(self.innerView.bounds),
                                               CGRectGetHeight(self.innerView.bounds));
            
            self.innerView.frame = innerViewFrame;
            [self.innerContainerView addSubview:self.innerView];
            
            contentOffsetY = CGRectGetMinY(self.innerContainerView.frame) + CGRectGetHeight(self.innerContainerView.frame);
        } else if (self.type == TYAlertViewTypeProgressView) {
            self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
            self.progressView.progress = self.progress;
            self.progressView.backgroundColor = UIColor.clearColor;
            self.progressView.progressTintColor = self.progressViewProgressTintColor;
            self.progressView.trackTintColor = self.progressViewTrackTintColor;
            
            if (self.progressViewProgressImage) {
                self.progressView.progressImage = self.progressViewProgressImage;
            }
            
            if (self.progressViewTrackImage) {
                self.progressView.trackImage = self.progressViewTrackImage;
            }
            
            CGRect progressViewFrame = CGRectMake(TYAlertViewPaddingWidth,
                                                  contentOffsetY + self.innerMarginHeight,
                                                  width - (TYAlertViewPaddingWidth * 2.0),
                                                  CGRectGetHeight(self.progressView.bounds));
            
            
            self.progressView.frame = progressViewFrame;
            [self.contentScrollView addSubview:self.progressView];
            
            contentOffsetY = CGRectGetMinY(self.progressView.frame) + CGRectGetHeight(self.progressView.frame);
            
            if (self.progressLabelText) {
                self.progressLabel = [UILabel new];
                self.progressLabel.text = self.progressLabelText;
                self.progressLabel.textColor = self.progressLabelTextColor;
                self.progressLabel.textAlignment = self.progressLabelTextAlignment;
                self.progressLabel.numberOfLines = self.progressLabelNumberOfLines;
                self.progressLabel.backgroundColor = UIColor.clearColor;
                self.progressLabel.font = self.progressLabelFont;
                self.progressLabel.lineBreakMode = self.progressLabelLineBreakMode;
                
                CGRect progressLabelFrame = CGRectMake(TYAlertViewPaddingWidth,
                                                       contentOffsetY + (self.innerMarginHeight / 2.0),
                                                       width - (TYAlertViewPaddingWidth * 2.0),
                                                       self.progressLabelNumberOfLines * self.progressLabelFont.lineHeight);
                
                self.progressLabel.frame = progressLabelFrame;
                [self.contentScrollView addSubview:self.progressLabel];
                
                contentOffsetY = CGRectGetMinY(self.progressLabel.frame) + CGRectGetHeight(self.progressLabel.frame);
            }
        } else if (self.type == TYAlertViewTypeTextField) {
            NSMutableArray *textFieldsArray = [NSMutableArray new];
            for (NSUInteger i = 0; i < self.numberOfTextFields; i++) {
                if (i != 0) {
                    UILabel *lineLabel = [self getLineLabelWithOffset:contentOffsetY];
                    lineLabel.frame = CGRectMake(TYAlertViewPaddingWidth, contentOffsetY, self.width - 2 * TYAlertViewPaddingWidth, CGRectGetHeight(lineLabel.frame));
                    [self.contentScrollView addSubview:lineLabel];
                    contentOffsetY += CGRectGetHeight(lineLabel.frame);
                }
                
                // -----
                TYAlertViewTextField *textField = [TYAlertViewTextField new];
                textField.tintColor = self.tintColor;
                textField.delegate = self;
                textField.tag = i;
                textField.backgroundColor = self.textFieldsBackgroundColor;
                
                textField.textColor = self.textFieldsTextColor;
                textField.font = self.textFieldsFont;
                textField.textAlignment = self.textFieldsTextAlignment;
                textField.clearsOnBeginEditing = self.textFieldsClearsOnBeginEditing;
                textField.adjustsFontSizeToFitWidth = self.textFieldsAdjustsFontSizeToFitWidth;
                textField.minimumFontSize = self.textFieldsMinimumFontSize;
                textField.clearButtonMode = self.textFieldsClearButtonMode;
                
                if (i == self.numberOfTextFields - 1) {
                    textField.returnKeyType = UIReturnKeyDone;
                } else {
                    textField.returnKeyType = UIReturnKeyNext;
                }
                
                if (self.textFieldsSetupHandler) {
                    self.textFieldsSetupHandler(textField, i);
                }
                
                CGRect textFieldFrame = CGRectMake(0.0, contentOffsetY, width, 44);
                
                textField.frame = textFieldFrame;
                [self.contentScrollView addSubview:textField];
                [textFieldsArray addObject:textField];
                
                contentOffsetY = CGRectGetMinY(textField.frame) + CGRectGetHeight(textField.frame);
            }
            
            self.textFieldsArray = textFieldsArray;
            
            contentOffsetY -= self.innerMarginHeight;
        }
        
        if (self.cancelAction && self.style == TYAlertViewStyleActionSheet && self.cancelButtonOffsetY != 0) {
            [self addCancelButton];
        }
        
        CGFloat buttonOffset = 0;
        NSInteger titleCount = self.actions.count;
        
        BOOL shouldAddLineAboveButton = !(self.style == TYAlertViewStyleActionSheet && self.title.length == 0 && self.message.length == 0 && !self.innerView);
        if (shouldAddLineAboveButton) {
            contentOffsetY += self.innerMarginHeight;
        }
       
        if (titleCount != 0) {
            UILabel *lineLabel = [self getLineLabelWithOffset:buttonOffset];
            [self.buttonScrollView addSubview:lineLabel];
            buttonOffset = CGRectGetMinY(lineLabel.frame) + CGRectGetHeight(lineLabel.frame);
        }
        
        if (titleCount > 2 || self.style == TYAlertViewStyleActionSheet) {
            for (NSUInteger i = 0; i < self.actions.count; i++) {
                
                if (i != 0 && shouldAddLineAboveButton) {
                    UILabel *lineLabel = [self getLineLabelWithOffset:buttonOffset];
                    [self.buttonScrollView addSubview:lineLabel];
                    buttonOffset = CGRectGetMinY(lineLabel.frame) + CGRectGetHeight(lineLabel.frame);
                }
                
                UIButton *button = [self createButtonWithAction:self.actions[i]];
                button.tag = i;
                [self.buttonScrollView addSubview:button];
                button.frame = CGRectMake(0, buttonOffset, self.width, self.buttonHeight);
                buttonOffset += CGRectGetHeight(button.frame);
            }
        } else if (titleCount == 2) {
            
            CGFloat lineWidth = 1 / [UIScreen mainScreen].scale;
            UIButton *firstButton = [self createButtonWithAction:self.actions[0]];
            UIButton *scenondButton = [self createButtonWithAction:self.actions[1]];
            UILabel *lineLabel = [self getLineLabelWithOffset:0];
            
            firstButton.frame = CGRectMake(0, buttonOffset, self.width / 2 - lineWidth / 2.f, self.buttonHeight);
            firstButton.tag = 0;
            scenondButton.frame = CGRectMake(self.width / 2 + lineWidth / 2.f, buttonOffset, self.width / 2 - lineWidth / 2.f, self.buttonHeight);
            scenondButton.tag = 1;
            lineLabel.frame = CGRectMake(self.width / 2, buttonOffset, lineWidth, self.buttonHeight);
            [self.buttonScrollView addSubview:firstButton];
            [self.buttonScrollView addSubview:scenondButton];
            [self.buttonScrollView addSubview:lineLabel];
            buttonOffset += CGRectGetHeight(lineLabel.frame);
            
        } else if (titleCount == 1) {
            UIButton *firstButton = [self createButtonWithAction:self.actions[0]];
            firstButton.frame = CGRectMake(0, buttonOffset, self.width, self.buttonHeight);
            firstButton.tag = 0;
            [self.buttonScrollView addSubview:firstButton];
            buttonOffset += CGRectGetHeight(firstButton.frame);
            
        }
        
        self.contentScrollView.contentSize = CGSizeMake(width, contentOffsetY);
        self.buttonScrollView.contentSize = CGSizeMake(width, buttonOffset);
        
    }
}

- (void)layoutViewsWithSize:(CGSize)size {
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = self.viewController.view.bounds.size;
    }
    
    // -----
    
    CGFloat width = self.width;
    
    // -----
    
    self.view.frame = CGRectMake(0.0, 0.0, size.width, size.height);
    self.backgroundView.frame = CGRectMake(0.0, 0.0, size.width, size.height);
    
    // -----
    CGFloat heightMax = size.height * 4.0 / 6.0;
    if (self.keyboardHeight != 0) {
        heightMax = (size.height - self.keyboardHeight) * 4.0 / 6.0;
    }
    
    if (self.style == TYAlertViewStyleActionSheet && self.cancelButtonOffsetY != 0 && self.cancelButton) {
        heightMax -= self.buttonHeight + self.cancelButtonOffsetY;
    }
    
    CGFloat contentHeight = self.contentScrollView.contentSize.height;
    CGFloat buttonHeight = self.buttonScrollView.contentSize.height;
    
    
    if (self.contentScrollView.contentSize.height + self.buttonScrollView.contentSize.height < heightMax) {
        heightMax = self.contentScrollView.contentSize.height + self.buttonScrollView.contentSize.height;
    } else {
        if (buttonHeight < heightMax * 0.3) {
            contentHeight = heightMax - buttonHeight;
        } else if (contentHeight < heightMax * 0.7) {
            buttonHeight = heightMax - contentHeight;
        } else {
            contentHeight = heightMax * 0.7;
            buttonHeight = heightMax * 0.3;
        }
    }
    
    // -----
    
    CGRect scrollViewFrame = CGRectZero;
    CGRect contentScrollViewFrame = CGRectZero;
    CGRect buttonScrollViewFrame = CGRectZero;
    
    CGAffineTransform scrollViewTransform = CGAffineTransformIdentity;
    CGFloat scrollViewAlpha = 1.0;
    
    if (self.style == TYAlertViewStyleAlert) {
        scrollViewFrame = CGRectMake((size.width - width) / 2.0, (size.height - self.keyboardHeight - heightMax) / 2.0, width, heightMax);
        contentScrollViewFrame = CGRectMake(0, 0, width, contentHeight);
        buttonScrollViewFrame = CGRectMake(0, CGRectGetMinY(contentScrollViewFrame) + CGRectGetHeight(contentScrollViewFrame) , width, buttonHeight);
        if (!self.isShowing) {
            scrollViewTransform = CGAffineTransformMakeScale(1.2, 1.2);
            
            scrollViewAlpha = 0.0;
        }
    } else {
        CGFloat bottomShift = 8.0;
        
        if (self.style == TYAlertViewStyleActionSheet && self.cancelButtonOffsetY != 0  && self.cancelButton) {
            bottomShift += self.buttonHeight + self.cancelButtonOffsetY;
        }
        
        scrollViewFrame = CGRectMake((size.width - width) / 2.0, size.height - bottomShift - heightMax, width, heightMax);
        contentScrollViewFrame = CGRectMake(0, 0, width, contentHeight);
        buttonScrollViewFrame = CGRectMake(0, CGRectGetMinY(contentScrollViewFrame) + CGRectGetHeight(contentScrollViewFrame), width, buttonHeight);
    }
    
    // -----
    
    if (self.style == TYAlertViewStyleActionSheet) {
        CGRect cancelButtonFrame = CGRectZero;
        
        if (self.isCancelButtonSperateWithSelf && self.cancelButton) {
            cancelButtonFrame = CGRectMake((size.width - width) / 2.0, size.height - self.cancelButtonOffsetY - self.buttonHeight, width, self.buttonHeight);
        }
        
        self.scrollViewCenterShowed = CGPointMake(CGRectGetMinX(scrollViewFrame) + (CGRectGetWidth(scrollViewFrame) / 2.0),
                                                  CGRectGetMinY(scrollViewFrame) + (CGRectGetHeight(scrollViewFrame) / 2.0));
        
        self.cancelButtonCenterShowed = CGPointMake(CGRectGetMinX(cancelButtonFrame) + (CGRectGetWidth(cancelButtonFrame) / 2.0),
                                                    CGRectGetMinY(cancelButtonFrame) + (CGRectGetHeight(cancelButtonFrame) / 2.0));
        
        // -----
        
        CGFloat commonHeight = CGRectGetHeight(scrollViewFrame) + 8.0;
        
        if (self.style == TYAlertViewStyleActionSheet && self.cancelButtonOffsetY != 0 && self.cancelButton) {
            commonHeight += self.buttonHeight + self.cancelButtonOffsetY;
        }
        
        self.scrollViewCenterHidden = CGPointMake(CGRectGetMinX(scrollViewFrame) + (CGRectGetWidth(scrollViewFrame) / 2.0),
                                                  CGRectGetMinY(scrollViewFrame) + (CGRectGetHeight(scrollViewFrame) / 2.0) + commonHeight + self.layerBorderWidth + self.layerShadowRadius);
        
        self.cancelButtonCenterHidden = CGPointMake(CGRectGetMinX(cancelButtonFrame) + (CGRectGetWidth(cancelButtonFrame) / 2.0),
                                                    CGRectGetMinY(cancelButtonFrame) + (CGRectGetHeight(cancelButtonFrame) / 2.0) + commonHeight);
        
        if (!self.isShowing) {
            scrollViewFrame.origin.y += commonHeight;
            
            if (self.style == TYAlertViewStyleActionSheet && self.cancelButtonOffsetY != 0 && self.cancelButton) {
                cancelButtonFrame.origin.y += commonHeight;
            }
        }
        
        // -----
        
        if (self.style == TYAlertViewStyleActionSheet && self.cancelButtonOffsetY != 0 && self.cancelButton) {
            self.cancelButton.frame = cancelButtonFrame;
            
            CGFloat offset = self.layerBorderWidth + self.layerShadowRadius;
            self.shadowCancelView.frame = CGRectInset(cancelButtonFrame, -offset, -offset);
            [self.shadowCancelView setNeedsDisplay];
            
            self.blurCancelView.frame = CGRectInset(cancelButtonFrame, -self.layerBorderWidth, -self.layerBorderWidth);
        }
    }
    
    
    
    self.contentView.frame = scrollViewFrame;
    self.contentView.transform = scrollViewTransform;
    self.contentView.alpha = scrollViewAlpha;
    
    self.contentScrollView.frame = contentScrollViewFrame;
    self.buttonScrollView.frame = buttonScrollViewFrame;
    
    CGFloat offset = self.layerBorderWidth + self.layerShadowRadius;
    self.shadowView.frame = CGRectInset(scrollViewFrame, -offset, -offset);
    self.shadowView.transform = scrollViewTransform;
    self.shadowView.alpha = scrollViewAlpha;
    [self.shadowView setNeedsDisplay];
    
    // -----
    
    self.blurView.frame = CGRectInset(scrollViewFrame, -self.layerBorderWidth, -self.layerBorderWidth);
    self.blurView.transform = scrollViewTransform;
    self.blurView.alpha = scrollViewAlpha;
}

- (void)addCancelButton {
    self.shadowCancelView = [TYAlertShadowView new];
    self.shadowCancelView.clipsToBounds = YES;
    self.shadowCancelView.userInteractionEnabled = NO;
    self.shadowCancelView.cornerRadius = self.layerCornerRadius;
    self.shadowCancelView.strokeColor = self.layerBorderColor;
    self.shadowCancelView.strokeWidth = self.layerBorderWidth;
    self.shadowCancelView.shadowColor = self.layerShadowColor;
    self.shadowCancelView.shadowBlur = self.layerShadowRadius;
    self.shadowCancelView.shadowOffset = self.layerShadowOffset;
    [self.view insertSubview:self.shadowCancelView belowSubview:self.contentView];
    
    self.blurCancelView = [[UIVisualEffectView alloc] initWithEffect:self.backgroundBlurEffect];
    self.blurCancelView.contentView.backgroundColor = self.backgroundColor;
    self.blurCancelView.clipsToBounds = YES;
    self.blurCancelView.layer.cornerRadius = self.layerCornerRadius;
    self.blurCancelView.layer.borderWidth = self.layerBorderWidth;
    self.blurCancelView.layer.borderColor = self.layerBorderColor.CGColor;
    self.blurCancelView.userInteractionEnabled = NO;
    [self.view insertSubview:self.blurCancelView aboveSubview:self.shadowCancelView];
    
    self.cancelButton = [self createButtonWithAction:self.cancelAction];
    [self.cancelButton removeTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelButton.layer.masksToBounds = YES;
    self.cancelButton.layer.cornerRadius = self.layerCornerRadius - self.layerBorderWidth - (self.layerBorderWidth ? 1.0 : 0.0);
    [self.view insertSubview:self.cancelButton aboveSubview:self.blurCancelView];
}

- (void)addBackgroundView {
    self.backgroundView.backgroundColor = self.coverColor;
    self.backgroundView.effect = self.coverBlurEffect;
}

- (void)addShadowView {
    self.shadowView = [TYAlertShadowView new];
    self.shadowView.clipsToBounds = YES;
    self.shadowView.userInteractionEnabled = NO;
    self.shadowView.cornerRadius = self.layerCornerRadius;
    self.shadowView.strokeColor = self.layerBorderColor;
    self.shadowView.strokeWidth = self.layerBorderWidth;
    self.shadowView.shadowColor = self.layerShadowColor;
    self.shadowView.shadowBlur = self.layerShadowRadius;
    self.shadowView.shadowOffset = self.layerShadowOffset;
    [self.view addSubview:self.shadowView];
}

- (void)addBlurView {
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:self.backgroundBlurEffect];
    self.blurView.contentView.backgroundColor = self.backgroundColor;
    self.blurView.clipsToBounds = YES;
    self.blurView.layer.cornerRadius = self.layerCornerRadius;
    self.blurView.layer.borderWidth = self.layerBorderWidth;
    self.blurView.layer.borderColor = self.layerBorderColor.CGColor;
    self.blurView.userInteractionEnabled = NO;
    [self.view addSubview:self.blurView];
}

- (void)addContentView {
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = UIColor.clearColor;
    self.contentView.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = self.layerCornerRadius - self.layerBorderWidth - (self.layerBorderWidth ? 1.0 : 0.0);
    [self.view addSubview:self.contentView];
}

- (void)addContentScrollView {
    self.contentScrollView = [UIScrollView new];
    self.contentScrollView.backgroundColor = UIColor.clearColor;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.alwaysBounceVertical = NO;
    self.contentScrollView.clipsToBounds = YES;
    [self.contentView addSubview:self.contentScrollView];
}

- (void)addButtonScrollView {
    self.buttonScrollView = [UIScrollView new];
    self.buttonScrollView.backgroundColor = UIColor.clearColor;
    self.buttonScrollView.showsVerticalScrollIndicator = NO;
    self.buttonScrollView.alwaysBounceVertical = NO;
    self.buttonScrollView.clipsToBounds = YES;
    [self.contentView addSubview:self.buttonScrollView];
}

#pragma mark - action

- (UIButton *)createButtonWithAction:(TYAlertAction *)action {
    return ({
        UIButton *button = [[UIButton alloc] init];
        button.titleLabel.font = action.titleFont;
        button.titleLabel.textAlignment = action.textAligment;
        button.adjustsImageWhenHighlighted = NO;
        if (action.accessibilityIdentifier) {
            button.accessibilityIdentifier = action.accessibilityIdentifier;
        }
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:action.titleColor forState:UIControlStateNormal];
        [button setTitleColor:action.titleColorHighlighted forState:UIControlStateHighlighted];
        [button setBackgroundImage:[TYAlertView image1x1WithColor:action.backgroundColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[TYAlertView image1x1WithColor:action.backgroundColorHighlighted] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[TYAlertView image1x1WithColor:action.backgroundColorHighlighted] forState:UIControlStateSelected];
        [button setTitle:action.title forState:UIControlStateNormal];
        if (action.textAligment == NSTextAlignmentLeft) {
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        } else if (action.textAligment == NSTextAlignmentRight) {
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
        button;
    });
}

- (UILabel *)getLineLabelWithOffset:(CGFloat)offsetY {
    return ({
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = HEXCOLOR(0xddddddd);
        label.height = 1 / [UIScreen mainScreen].scale;
        label.width = self.width;
        label.top = offsetY;
        label;
    });
}

#pragma mark - textField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag < self.textFieldsArray.count - 1) {
        TYAlertViewTextField *nextTextField = [self.textFieldsArray objectAtIndex:textField.tag + 1];
        [nextTextField becomeFirstResponder];
    } else if (textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - call back

- (void)cancelAction:(UIGestureRecognizer *)gesture {
    if (!self.cancelOnTouch) {
        return;
    }
    [self dismissAnimated:YES completionHandler:nil];
}

- (void)cancelButtonAction:(UIButton *)cancelButton {
    [cancelButton setSelected:YES];
    
    if (self.dismissOnAction) {
        [self dismissAnimated];
    }
    
    if (self.actionHandler) {
        self.actionHandler(self, 0);
    }
    
    if (self.cancelAction && self.cancelAction.alertAction) {
        self.cancelAction.alertAction();
    }
    
}

- (void)buttonAction:(UIButton *)button {
    [button setSelected:YES];
    
    if (self.dismissOnAction) {
        [self dismissAnimated];
    }
    TYAlertAction *action = [self.actions objectAtIndex:button.tag];
    if (self.actionHandler) {
        self.actionHandler(self, action.index);
    }
    
    if (action && action.alertAction) {
        action.alertAction();
    }
}


- (void)addAlertActions:(NSArray<TYAlertAction *> *)actions {
    [actions enumerateObjectsUsingBlock:^(TYAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addAlertAction:obj];
    }];
}

- (void)addAlertAction:(TYAlertAction * )alertAction {
    if (alertAction.isCancel) {
        self.cancelAction = alertAction;
        self.cancelButtonTitle = alertAction.title;
        alertAction.index = 0;
        
        [self.actions enumerateObjectsUsingBlock:^(TYAlertAction *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isCancel) {
                NSAssert(NO, @"AlertView cant's has two cancel button");
            }
            obj.index += 1;
        }];
        
        if (self.style != TYAlertViewStyleActionSheet) {
            if (self.actions.count < 2) {
                [self.actions insertObject:alertAction atIndex:0];
            } else {
                [self.actions addObject:alertAction];
            }
        }
    } else {
        alertAction.index = self.actions.count;
        if (self.cancelAction && self.style == TYAlertViewStyleAlert) {
            if (self.actions.count < 2) {
                [self.actions addObject:alertAction];
            } else {
                if (self.actions.count == 2) {
                    [self.actions removeObject:self.cancelAction];
                    [self.actions addObject:self.cancelAction];
                }
                NSInteger cancelIndex = [self.actions indexOfObject:self.cancelAction];
                [self.actions insertObject:alertAction atIndex:cancelIndex];
            }
        } else {
            if (self.style == TYAlertViewStyleActionSheet) {
                alertAction.index = self.actions.count + 1;
            }
            [self.actions addObject:alertAction];
        }
    }
}


#pragma mark - private method
#pragma mark - getters

- (CGFloat)innerMarginHeight {
    return self.style == TYAlertViewStyleAlert ? 20.0 : 12.0;
}

- (BOOL)isCancelButtonSperateWithSelf {
    return self.style == TYAlertViewStyleActionSheet && self.cancelButtonOffsetY != 0;
}

- (CGFloat)width {
    CGSize size = [TYAlertView appWindow].bounds.size;
    
    if (_width != 0) {
        CGFloat result = MIN(size.width, size.height);
        
        if (_width < result) {
            result = _width;
        }
        
        return result;
    }
    
    if (self.style == TYAlertViewStyleAlert) {
        return MIN(size.width, size.height) - 30 * 2;
    }
    
    return MIN(size.width, size.height) - 16.0;
}

+ (CGFloat)suggestWidthWithStyle:(TYAlertViewStyle)style {
    CGSize size = [self appWindow].bounds.size;
    
    if (style == TYAlertViewStyleAlert) {
        return MIN(size.width, size.height) - 30 * 2;
    }
    
    return MIN(size.width, size.height) - 16.0;
}

+ (UIWindow *)appWindow {
    return [UIApplication sharedApplication].windows[0];
}

+ (UIImage *)image1x1WithColor:(UIColor *)color {
    if (!color) return nil;
    
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - deprecated

+ (void)simpleAlertWithTitle:(NSString *)title
                     message:(NSString *)message
                 cancelTitle:(NSString *)cancelTitle {
    [self alertWithTitle:title message:message customView:nil cancelTitle:cancelTitle cancelColor:nil otherTitles:nil clickAction:nil];
}

+(void)alertWithTitle:(NSString *)title
              message:(NSString *)message
          cancelTitle:(NSString *)cancelTitle
          otherTitles:(NSArray *)titles
          clickAction:(void (^)(TYAlertView *, NSInteger))clickAction {
    [self alertWithTitle:title message:message customView:nil cancelTitle:cancelTitle cancelColor:nil otherTitles:titles clickAction:clickAction];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
            customView:(UIView *)customView
           cancelTitle:(NSString *)cancelTitle
           cancelColor:(UIColor *)cancelColor
           otherTitles:(NSArray *)titles
           clickAction:(void (^)(TYAlertView *, NSInteger))clickAction {
    
    [self alertInView:nil title:title message:message customView:customView cancelTitle:cancelTitle cancelColor:cancelColor otherTitles:titles clickAction:clickAction];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
             alignment:(NSTextAlignment)alignment
           cancelTitle:(NSString *)cancelTitle
           otherTitles:(NSArray *)titles
           clickAction:(void(^)(TYAlertView *view,NSInteger buttonIndex))clickAction {
    [self alertInView:nil title:title message:message alignment:alignment customView:nil cancelTitle:cancelTitle cancelColor:nil otherTitles:titles clickAction:clickAction];
}

+ (void)alertInView:(UIView *)view
              title:(NSString *)title
            message:(NSString *)message
         customView:(UIView *)customView
        cancelTitle:(NSString *)cancelTitle
        cancelColor:(UIColor *)cancelColor
        otherTitles:(NSArray *)titles
        clickAction:(void (^)(TYAlertView *, NSInteger))clickAction {
    
    [self alertInView:view
                title:title
              message:message
            alignment:NSTextAlignmentCenter
           customView:customView
          cancelTitle:cancelTitle
          cancelColor:cancelColor
          otherTitles:titles
          clickAction:clickAction];
}

+ (void)alertInView:(UIView *)view
              title:(NSString *)title
            message:(NSString *)message
          alignment:(NSTextAlignment)alignment
         customView:(UIView *)customView
        cancelTitle:(NSString *)cancelTitle
        cancelColor:(UIColor *)cancelColor
        otherTitles:(NSArray *)titles
        clickAction:(void (^)(TYAlertView *, NSInteger buttonIndex))clickAction {
    TYAlertView *alertView =  [[TYAlertView alloc] initWithViewAndTitle:title message:message view:customView style:TYAlertViewStyleAlert buttonTitles:titles cancelButtonTitle:cancelTitle actionHandler:clickAction];
    alertView.messageTextAlignment = alignment;
    if (view) {
        [alertView showInView:view];
    } else {
        [alertView showAnimated];
    }
}

@end



