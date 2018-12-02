//
//  AMButtonFactory.h
//  tradingSystem
//
//  Created by kunlun.xy on 15/12/1.
//  Copyright © 2015年 xiami. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AMButtonFactory : NSObject
+ (UIButton *)buttonWithImageName:(NSString *)imageName;
+ (UIButton *)buttonWithImageName:(NSString *)imageName size:(CGFloat)size;
+ (UIButton *)buttonWithImageName:(NSString *)imageName size:(CGFloat)size color:(UIColor *)color;
+ (void)setButtonImage:(UIButton *)button WithimageName:(NSString *)imageName;
+ (void)setButtonImage:(UIButton *)button WithimageName:(NSString *)imageName size:(CGFloat)size;
+ (void)setButtonImage:(UIButton *)button WithimageName:(NSString *)imageName size:(CGFloat)size color:(UIColor *)color;
+ (void)setButtonImage:(UIButton *)button WithimageName:(NSString *)imageName size:(CGFloat)size color:(UIColor *)color state:(UIControlState)state;
@end
