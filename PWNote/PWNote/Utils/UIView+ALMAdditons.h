//
//  UIView+Additons.h
//  TTUtilities
//
//  Created by OSang on 15/10/16.
//  Copyright © 2015年 TTPod. All rights reserved.
//


#import <UIKit/UIKit.h>

#define kScreenWidth [UIView screenWidth]
#define kScreenHeight [UIView screenHeight]
#define kDefaultSplitLine [UIView defaultSplitLine]
#define kFillSplitLine [UIView fillSplitLine]
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define Screen3P5Inch ([[UIScreen mainScreen] currentMode].size.height < 1136)

#define IS_IPHONE_X (kScreenHeight == 812.0f || kScreenWidth == 812.0f) ? YES : NO
#define Height_NavContentBar    44.0f
#define kSafeAreaStatusBarHeight ((IS_IPHONE_X)?44.0f: 20.0f)
#define kSafeAreaNavBarHeight ((IS_IPHONE_X)?88.0f: 64.0f)
#define kSafeAreaTabBarHeight ((IS_IPHONE_X)?83.0f: 49.0f)
#define kSafeArea_Bottom ((IS_IPHONE_X)?34.f: 0.f)




/**
 *  UIView的辅助类，方便快捷地访问使用UIView中的各种属性，减少冗余代码量
 */
@interface UIView (ALMAdditons)

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *alm_borderColor;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) CGSize size;

- (void)setBackgroundImage:(UIImage *)img;
+ (CGFloat)screenHeight;
+ (CGFloat)screenWidth;
/**
 *  分割线
 *  (16,0,kScreenWidth - 32,0.5)
 *
 *  @return 通用分割线
 */
+ (UIView *)defaultSplitLine;

/**
 *  分割线
 *  (0,0,kScreenWidth,0.5)
 *
 *  @return 填满分割线
 */
+ (UIView *)fillSplitLine;
/**
 *  有高度的分割uiview
 *
 *  @param height height
 *
 *  @return 分割线
 */
+ (UIView *)splitLineWithHeight:(CGFloat)height;

@end
