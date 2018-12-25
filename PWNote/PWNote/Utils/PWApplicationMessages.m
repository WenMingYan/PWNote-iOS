//
//  PWApplicationMessages.m
//  PWNote
//
//  Created by mingyan on 2018/12/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWApplicationMessages.h"

@implementation PWApplicationMessages

static PWApplicationMessages *__onetimeClass;
+ (instancetype)sharedInstance {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        __onetimeClass = [[PWApplicationMessages alloc] init];
    });
    return __onetimeClass;
}

- (NSString *)version {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

@end
