//
//  AMButtonFactory.m
//  tradingSystem
//
//  Created by kunlun.xy on 15/12/1.
//  Copyright © 2015年 xiami. All rights reserved.
//


#import "AMButtonFactory.h"
#import "AMIconfont.h"

static int loadIconTime = 0;
static NSString *plistPath;
static NSMutableDictionary *listData;

@implementation AMButtonFactory

+ (UIButton *)buttonWithImageName:(NSString *)imageName {
    CGFloat size = 24.0f;
    UIColor *color = [UIColor blackColor];
    return [self buttonWithImageName:imageName size:size color:color];
}

+ (UIButton *)buttonWithImageName:(NSString *)imageName size:(CGFloat)size {
    UIColor *color = [UIColor blackColor];
    return [self buttonWithImageName:imageName size:size color:color];
}

+ (UIButton *)buttonWithImageName:(NSString *)imageName size:(CGFloat)size color:(UIColor *)color {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    if (![imageName hasPrefix:@"iconFont"]) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    } else {
        if (loadIconTime == 0) {
            loadIconTime++;
            plistPath = [[NSBundle mainBundle] pathForResource:@"iconfont" ofType:@"plist"];
            listData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        }
        NSString *unicodeString = (NSString *) listData[imageName];
        NSScanner *scanner = [NSScanner scannerWithString:unicodeString];
        unsigned unicode;
        [scanner scanHexInt:&unicode];
        NSString *stringWithUnicodeChar = [NSString stringWithFormat:@"%C", (unichar)unicode];
        UIFont *font = [UIFont fontWithName:@"iconfont" size:size];
        button.titleLabel.font = font;
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitle:stringWithUnicodeChar forState:UIControlStateNormal];
    }
    return button;
}

+ (void)setButtonImage:(UIButton *)button WithimageName:(NSString *)imageName {
    CGFloat size = 24.0f;
    UIColor *color = [UIColor blackColor];
    [self setButtonImage:button WithimageName:imageName size:size color:color];
}

+ (void)setButtonImage:(UIButton *)button WithimageName:(NSString *)imageName size:(CGFloat)size {
    UIColor *color = [UIColor blackColor];
    [self setButtonImage:button WithimageName:imageName size:size color:color];
}

+ (void)setButtonImage:(UIButton *)button WithimageName:(NSString *)imageName size:(CGFloat)size color:(UIColor *)color {
    [self setButtonImage:button WithimageName:imageName size:size color:color state:UIControlStateNormal];
}

+ (void)setButtonImage:(UIButton *)button WithimageName:(NSString *)imageName size:(CGFloat)size color:(UIColor *)color state:(UIControlState)state {
    [button setTitle:imageName forState:state];
    if (color) {
        [button setTitleColor:color forState:state];
    }
    button.titleLabel.font = [AMIconfont fontWithSize:size];
}

@end
