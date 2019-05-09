//
//  UIView+TYFrame.m
//  TYUIKit
//
//  Created by TuyaInc on 2018/12/17.
//

#import "UIView+TYFrame.h"

@implementation UIView (TYFrame)

- (CGFloat)ty_left {
    return self.frame.origin.x;
}


- (void)setTy_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)ty_top {
    return self.frame.origin.y;
}


- (void)setTy_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)ty_right {
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setTy_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)ty_bottom {
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setTy_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (CGFloat)ty_centerX {
    return self.center.x;
}


- (void)setTy_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


- (CGFloat)ty_centerY {
    return self.center.y;
}


- (void)setTy_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


- (CGFloat)ty_width {
    return self.frame.size.width;
}


- (void)setTy_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)ty_height {
    return self.frame.size.height;
}


- (void)setTy_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)ty_origin {
    return self.frame.origin;
}


- (void)setTy_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGSize)ty_size {
    return self.frame.size;
}

- (void)setTy_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
