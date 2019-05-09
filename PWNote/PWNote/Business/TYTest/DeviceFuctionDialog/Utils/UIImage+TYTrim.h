//
//  UIImage+TYTrim.h
//  TYUIKit
//
//  Created by TuyaInc on 2018/12/20.
//

#import <UIKit/UIKit.h>

@interface UIImage (TYTrim)

#pragma mark - Resize
- (UIImage *)ty_imageWithScaling:(CGFloat)scaling;
- (UIImage *)ty_imageWithResize:(CGSize)size;
- (UIImage *)ty_imageWithResize:(CGSize)size contentMode:(UIViewContentMode)contentMode;

#pragma mark - Crop
- (UIImage *)ty_imageWithCropRect:(CGRect)rect;

#pragma mark - Corner/Border
- (UIImage *)ty_imageWithCornerRadius:(CGFloat)radius;
- (UIImage *)ty_imageWithCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

#pragma mark - TintColor
- (UIImage *)ty_imageWithTintColor:(UIColor *)color;

#pragma mark - Rotation
- (UIImage *)ty_imageWithHorizontalFlip;
- (UIImage *)ty_imageWithVerticalFlip;

@end
