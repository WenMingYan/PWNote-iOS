//
//  UIView+Additons.m
//  TTUtilities
//
//  Created by OSang on 15/10/16.
//  Copyright © 2015年 TTPod. All rights reserved.
//


#import "UIView+ALMAdditons.h"

@implementation UIView (ALMAdditons)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (UIColor *)alm_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setAlm_borderColor:(UIColor *)alm_borderColor {
    self.layer.borderColor = alm_borderColor.CGColor;
}

- (UIColor *)shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = [shadowColor CGColor];
}

- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGPoint center = self.center;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    self.center = center;
}

- (void)setBackgroundImage:(UIImage *)img {
    [self.layer setContents:(id)[img CGImage]];
}

+ (CGFloat)screenHeight {
    CGFloat height = 0;

    if (height == 0) {
        height = [[UIScreen mainScreen] bounds].size.height;
    }

    return height;
}

+ (CGFloat)screenWidth {
    CGFloat width = 0;
    if (width == 0) {
        width = [[UIScreen mainScreen] bounds].size.width;
    }

    return width;
}

/**
 *  通用分割线
 */
+ (UIView *)defaultSplitLine {
    UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(16, 0, kScreenWidth - 32, 0.5)];
    splitLine.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    return splitLine;
}

+ (CGFloat)pixel:(NSInteger)pixel {
    static CGFloat scale = 0.0;
    if (scale == 0.0) {
        scale = [[UIScreen mainScreen] scale];
        if ([[UIScreen mainScreen] respondsToSelector:@selector(nativeScale)]) {
            scale = [[UIScreen mainScreen] nativeScale];
        }
    }
    return pixel * 1.0f / scale;
}

/**
 *  左右填满分割线
 */
+ (UIView *)fillSplitLine {
    UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [UIView pixel:1])];
    splitLine.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    return splitLine;
}

+ (UIView *)splitLineWithHeight:(CGFloat)height {
    UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    splitLine.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    return splitLine;
}
@end
