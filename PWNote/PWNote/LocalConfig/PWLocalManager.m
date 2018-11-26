//
//  PWLocalManager.m
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWLocalManager.h"

@implementation PWLocalManager

static PWLocalManager *__onetimeClass;
+ (instancetype)sharedInstance {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        __onetimeClass = [[PWLocalManager alloc]init];
    });
    return __onetimeClass;
}

@end
