//
//  TYAlertView.h
//  Pods
//
//  Created by Lucca on 2019/2/20.
//
//

#import <UIKit/UIKit.h>

typedef void(^AlertAtcion)(void);

@interface TYAlertAction: NSObject

/** Default is "Done" */
@property (nonatomic, strong, nullable) NSString *title;

/** Default is  */
@property (nonatomic, strong, nullable) UIColor *titleColor ;

/** Default is titleColor */
@property (nonatomic, strong, nullable) UIColor *titleColorHighlighted ;

/** Default is UIColor.clearColor */
@property (nonatomic, strong, nullable) UIColor *backgroundColor ;

/** Default is HEXCOLOR(0xe5e5e5) */
@property (nonatomic, strong, nullable) UIColor *backgroundColorHighlighted;

/**
 Default:
 [UIFont systemOfFont:16];
 */
@property (nonatomic, strong, nullable) UIFont *titleFont;

/** UITest id */
@property (nonatomic, strong, nullable) NSString *accessibilityIdentifier;

/** Default is "NSTextAlignmentCenter" */
@property (nonatomic, assign) NSTextAlignment textAligment;

/**
 Default is NO
 if yes:
 font will be medium bold, index is 0, view location always be the last one
 and seprate with main view if is actionsheet style alertview
 */
@property (nonatomic, assign) BOOL            isCancel;



@property (nonatomic, copy) AlertAtcion alertAction;


+ (TYAlertAction *)actionWithTitle:(nullable NSString *)title
                       alertAciton:(nullable AlertAtcion)action;

+ (TYAlertAction *)actionWithTitle:(NSString *)title
                             color:(UIColor *)color
                              font:(UIFont *)font
                       alertAciton:(AlertAtcion)action;

+ (TYAlertAction *)actionWithTitle:(nullable NSString *)title
                        titleColor:(nullable UIColor *)titleColor
             titleColorHighlighted:(nullable UIColor *)titleColorHighlighted
                   backgroundColor:(nullable UIColor *)backgroundColor
        backgroundColorHighlighted:(nullable UIColor *)backgroundColorHighlighted
                              font:(nullable UIFont *)font
                       alertAciton:(nullable AlertAtcion)action
                      textAligment:(NSTextAlignment)textAligment
                          isCancel:(BOOL)isCancel;

@end

typedef enum : NSUInteger {
    TYAlertViewStyleAlert,
    TYAlertViewStyleActionSheet
} TYAlertViewStyle;


@class TYAlertView;

typedef void (^ _Nullable TYAlertViewTextFieldsSetupHandler)(UITextField * _Nonnull textField, NSUInteger index);
typedef void (^ _Nullable TYAlertViewHandler)(TYAlertView * _Nonnull alertView);
typedef void (^ _Nullable TYAlertViewActionHandler)(TYAlertView * _Nonnull alertView, NSInteger buttonIndex);
typedef void (^ _Nullable TYAlertHandler)(void);

@interface TYAlertView : NSObject

extern CGFloat const TYAlertViewPaddingWidth;

#pragma mark - style property
/** Is action "show" already had been executed */
@property (nonatomic, assign, readonly, getter=isShowing) BOOL showing;
/** Is alert view visible right now */
@property (nonatomic, assign, readonly, getter=isVisible) BOOL visible;

@property (nonatomic, assign, readonly) TYAlertViewStyle style;

@property (nonatomic, strong) UIColor *tintColor;


/**
 Default:
 if (alert with activityIndicator || progressView) then NO
 else YES
 */
@property (nonatomic, assign, getter=isCancelOnTouch) BOOL cancelOnTouch;

/**
 Dismiss alert view on action, cancel and destructive
 Default is YES
 */
@property (nonatomic, assign, getter=isDismissOnAction) BOOL dismissOnAction;

@property (copy, nonatomic, readonly, nullable) NSArray *textFieldsArray;

/** Default is 0 */
@property (nonatomic, assign) NSInteger tag;

#pragma mark - Style properties

/**
 Color hides main view when alert view is showing
 Default is [UIColor colorWithWhite:0.0 alpha:0.35]
 */
@property (nonatomic, strong, nullable) UIColor *coverColor ;
/** Default is nil */
@property (nonatomic, strong, nullable) UIBlurEffect *coverBlurEffect ;
/** Default is 1.0 */
@property (nonatomic, assign) CGFloat coverAlpha ;
/** Default is UIColor.whiteColor */
@property (nonatomic, strong, nullable) UIColor *backgroundColor ;
/** Default is nil */
@property (nonatomic, strong, nullable) UIBlurEffect *backgroundBlurEffect ;


/**
 Default:
 if (style == LGAlertViewStyleAlert) then window.width - 60
 else window.width - 16.0
 */
@property (nonatomic, assign) CGFloat width ;

/** Default is YES */
@property (nonatomic, assign) BOOL shouldDismissAnimated ;

#pragma marl - Layer properties
/**
 Default:
 if (iOS < 9.0) then 6.0
 else 12.0
 */
@property (nonatomic, assign) CGFloat layerCornerRadius ;
/** Default is nil */
@property (nonatomic, strong, nullable) UIColor *layerBorderColor ;
/** Default is 0.0 */
@property (nonatomic, assign) CGFloat layerBorderWidth ;
/** Default is nil */
@property (nonatomic, strong, nullable) UIColor *layerShadowColor ;
/** Default is 0.0 */
@property (nonatomic, assign) CGFloat layerShadowRadius ;
/** Default is CGPointZero */
@property (nonatomic, assign) CGPoint layerShadowOffset ;


#pragma mark - Title properties

@property (copy, nonatomic, readonly, nullable) NSString *title;

/**
 Default:
 if (style == LGAlertViewStyleAlert) then UIColor.blackColor
 else UIColor.grayColor
 */
@property (nonatomic, strong, nullable) UIColor *titleTextColor ;
/** Default is NSTextAlignmentCenter */
@property (nonatomic, assign) NSTextAlignment titleTextAlignment ;

// Default is NO and will take effect only title is nonnull
@property (nonatomic, assign) BOOL seperateLineBetweenTitleAndMessage;

/**
 Default:
 if (style == LGAlertViewStyleAlert) then [UIFont boldSystemFontOfSize:18.0]
 else [UIFont boldSystemFontOfSize:14.0]
 */
@property (nonatomic, strong, nullable) UIFont *titleFont ;

#pragma mark - Message properties

@property (copy, nonatomic, readonly, nullable) NSString *message;

/**
 Default:
 if (style == TYAlertViewStyleAlert) then UIColor.blackColor
 else UIColor.grayColor
 */
@property (nonatomic, strong, nullable) UIColor *messageTextColor ;
/** Default is NSTextAlignmentCenter */
@property (nonatomic, assign) NSTextAlignment messageTextAlignment ;
/** Default is [UIFont systemFontOfSize:14.0] */
@property (nonatomic, strong, nullable) UIFont *messageFont;
/** Default is 3.f */
@property (nonatomic, assign) CGFloat messageLineSpacing;


#pragma mark - Progress view properties

@property (nonatomic, assign) float progress;
/** Default is tintColor */
@property (nonatomic, strong, nullable) UIColor *progressViewProgressTintColor ;
/** Default is [UIColor colorWithWhite:0.8 alpha:1.0] */
@property (nonatomic, strong, nullable) UIColor *progressViewTrackTintColor ;
/** Default is nil */
@property (nonatomic, strong, nullable) UIImage *progressViewProgressImage ;
/** Default is nil */
@property (nonatomic, strong, nullable) UIImage *progressViewTrackImage ;

#pragma mark - Progress label properties

@property (nonatomic, strong, nullable) NSString *progressLabelText;

@property (nonatomic, strong, nullable) UIColor *progressLabelTextColor ;

@property (nonatomic, assign) NSTextAlignment progressLabelTextAlignment ;
/** Default is [UIFont systemFontOfSize:14.0] */
@property (nonatomic, strong, nullable) UIFont *progressLabelFont ;
/** Default is 1 */
@property (nonatomic, assign) NSUInteger progressLabelNumberOfLines ;
/** Default is NSLineBreakByTruncatingTail */
@property (nonatomic, assign) NSLineBreakMode progressLabelLineBreakMode ;

#pragma mark - Text fields properties

/** Default is [UIColor colorWithWhite:0.97 alpha:1.0] */
@property (nonatomic, strong, nullable) UIColor *textFieldsBackgroundColor ;
/** Default is UIColor.blackColor */
@property (nonatomic, strong, nullable) UIColor *textFieldsTextColor ;
/** Default is [UIFont systemFontOfSize:16.0] */
@property (nonatomic, strong, nullable) UIFont *textFieldsFont ;
/** Default is NSTextAlignmentLeft */
@property (nonatomic, assign) NSTextAlignment textFieldsTextAlignment ;
/** Default is NO */
@property (nonatomic, assign) BOOL textFieldsClearsOnBeginEditing ;
/** Default is NO */
@property (nonatomic, assign) BOOL textFieldsAdjustsFontSizeToFitWidth ;
/** Default is 12.0 */
@property (nonatomic, assign) CGFloat textFieldsMinimumFontSize ;
/** Default is UITextFieldViewModeAlways */
@property (nonatomic, assign) UITextFieldViewMode textFieldsClearButtonMode ;


#pragma mark - Callbacks

/** To avoid retain cycle, do not forget about weak reference to self */
@property (copy, nonatomic) TYAlertViewHandler willShowHandler;
/** To avoid retain cycle, do not forget about weak reference to self */
@property (copy, nonatomic) TYAlertViewHandler didShowHandler;

/** To avoid retain cycle, do not forget about weak reference to self */
@property (copy, nonatomic) TYAlertViewHandler willDismissHandler;
/** To avoid retain cycle, do not forget about weak reference to self */
@property (copy, nonatomic) TYAlertViewHandler didDismissHandler;

- (nonnull instancetype)initSimpleAlertWithTitle:(NSString *)title
                                 message:(NSString *)message
                                   style:(TYAlertViewStyle)style;

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                                style:(TYAlertViewStyle)style
                         buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                        actionHandler:(TYAlertViewActionHandler)actionHandler;


- (nonnull instancetype)initWithViewAndTitle:(nullable NSString *)title
                                     message:(nullable NSString *)message
                                        view:(nullable UIView *)view
                                       style:(TYAlertViewStyle)style
                                buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                           cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                               actionHandler:(TYAlertViewActionHandler)actionHandler;


- (nonnull instancetype)initWithTextFieldAndTitle:(nullable NSString *)title
                                          message:(nullable NSString *)message
                                numberOfTextField:(NSInteger)numberOfTextFields
                           textFieldsSetupHandler:(TYAlertViewTextFieldsSetupHandler)textFieldsSetupHandler
                                     buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                                cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                    actionHandler:(TYAlertViewActionHandler)actionHandler;

- (nonnull instancetype)initWithProgressViewAndTitle:(nullable NSString *)title
                                             message:(nullable NSString *)message
                                            progress:(float)progress
                                   progressLabelText:(nullable NSString *)progressLabelText
                                               style:(TYAlertViewStyle)style
                                        buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                                   cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                       actionHandler:(TYAlertViewActionHandler)actionHandler;
#pragma mark - class method

+ (nonnull instancetype)showSimpleAlertViewWithTitle:(nullable NSString *)title
                                             message:(nullable NSString *)message
                                               style:(TYAlertViewStyle)style
                                         cancelTitle:(nullable NSString *)cancelTitle;


+ (nonnull instancetype)showTextFieldAlertViewWithTitle:(nullable NSString *)title
                                                message:(nullable NSString *)message
                                      numberOfTextField:(NSInteger)numberOfTextFields
                                 textFieldsSetupHandler:(TYAlertViewTextFieldsSetupHandler)textFieldsSetupHandler
                                           buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                                      cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                          actionHandler:(TYAlertViewActionHandler)actionHandler;

+ (nonnull instancetype)showAlertViewWithTitle:(nullable NSString *)title
                                       message:(nullable NSString *)message
                                          view:(nullable UIView *)view
                                         style:(TYAlertViewStyle)style
                                  buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                 actionHandler:(TYAlertViewActionHandler)actionHandler;


+ (nonnull instancetype)showProgressAlertViewWithTitle:(nullable NSString *)title
                                               message:(nullable NSString *)message
                                              progress:(float)progress
                                     progressLabelText:(nullable NSString *)progressLabelText
                                                 style:(TYAlertViewStyle)style
                                          buttonTitles:(nullable NSArray<NSString *> *)buttonTitles
                                     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                         actionHandler:(TYAlertViewActionHandler)actionHandler;


- (nonnull instancetype)init __attribute__((unavailable("use \"- initWith...\" instead")));
+ (nonnull instancetype)new __attribute__((unavailable("use \"+ showXxxAlertViewWith...\" instead")));


/**
 if alert with cancelTitle
 actions added will insert before cancel action
 */
- (void)addAlertActions:(nonnull NSArray<TYAlertAction *> *)actions;
- (void)addAlertAction:(nonnull TYAlertAction *)alertAction;
/**
 If no view :
 alert will show on it's custom window,
 and the window will become key window.
 else :
 alert will add to the view
 */
- (void)show;
- (void)showInView:(UIView *)view;
- (void)showAnimated:(BOOL)animated completionHandler:(TYAlertHandler)completionHandler;

- (void)dismiss;
- (void)dismissAnimated:(BOOL)animated completionHandler:(TYAlertHandler)completionHandler;

/**
 if you not set alertView's width
 use suggest width to init your view show in alertView
 else please use the alertView's width you set
 */
+ (CGFloat)suggestWidthWithStyle:(TYAlertViewStyle)style;

#pragma mark - deprecated

/**
 these method is deprecated, please use above method instead
 */
+ (void)simpleAlertWithTitle:(NSString *)title
                     message:(NSString *)message
                 cancelTitle:(NSString *)cancelTitle
DEPRECATED_MSG_ATTRIBUTE("use showSimpleAlertViewWithTitle:message:calcelTitle: instead");

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
            customView:(UIView *)customView
           cancelTitle:(NSString *)cancelTitle
           cancelColor:(UIColor *)cancelColor
           otherTitles:(NSArray *)titles
           clickAction:(void (^)(TYAlertView *, NSInteger buttonIndex))clickAction
DEPRECATED_MSG_ATTRIBUTE("use showAlertViewWithTitle:message:view:style:buttonTitles:cancelButtonTitle:actionHandler: instead");

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
           cancelTitle:(NSString *)cancelTitle
           otherTitles:(NSArray *)titles
           clickAction:(void(^)(TYAlertView *view,NSInteger buttonIndex))clickAction
DEPRECATED_MSG_ATTRIBUTE("use showAlertViewWithTitle:message:view:style:buttonTitles:cancelButtonTitle:actionHandler: instead");

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
             alignment:(NSTextAlignment)alignment
           cancelTitle:(NSString *)cancelTitle
           otherTitles:(NSArray *)titles
           clickAction:(void(^)(TYAlertView *view,NSInteger buttonIndex))clickAction
DEPRECATED_MSG_ATTRIBUTE("use showAlertViewWithTitle:message:view:style:buttonTitles:cancelButtonTitle:actionHandler: instead");

+ (void)alertInView:(UIView *)view
              title:(NSString *)title
            message:(NSString *)message
         customView:(UIView *)customView
        cancelTitle:(NSString *)cancelTitle
        cancelColor:(UIColor *)cancelColor
        otherTitles:(NSArray *)titles
        clickAction:(void (^)(TYAlertView *, NSInteger buttonIndex))clickAction
DEPRECATED_MSG_ATTRIBUTE("use showAlertViewWithTitle:message:view:style:buttonTitles:cancelButtonTitle:actionHandler: instead");

+ (void)alertInView:(UIView *)view
              title:(NSString *)title
            message:(NSString *)message
          alignment:(NSTextAlignment)alignment
         customView:(UIView *)customView
        cancelTitle:(NSString *)cancelTitle
        cancelColor:(UIColor *)cancelColor
        otherTitles:(NSArray *)titles
        clickAction:(void (^)(TYAlertView *, NSInteger buttonIndex))clickAction
DEPRECATED_MSG_ATTRIBUTE("use showAlertViewWithTitle:message:view:style:buttonTitles:cancelButtonTitle:actionHandler: instead");

@end
