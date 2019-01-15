//
//  PWSkinManager.m
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWSkinManager.h"

@implementation PWSkinManager

static PWSkinManager *__onetimeClass;

+ (instancetype)sharedInstance {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        __onetimeClass = [[self alloc] init];
    });
    return __onetimeClass;
}

- (UIColor *)whiteColor {
    return [UIColor whiteColor];
}

- (UIColor *)titleColor {
    return [UIColor blackColor];
}

- (UIColor *)lightSubTitleColor {
    return [UIColor lightGrayColor];
}

- (UIColor *)subTitleColor {
    return [UIColor grayColor];
}

- (UIColor *)themeColor {
    return [UIColor orangeColor];
}

- (UIColor *)lightBackgroundColor {
    return [UIColor lightGrayColor];
}

- (CGFloat)margin {
    return 16;
}

@end
