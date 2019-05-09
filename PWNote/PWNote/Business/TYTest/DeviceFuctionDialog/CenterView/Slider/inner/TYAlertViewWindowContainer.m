//
//  TYAlertViewWindowContainer.m
//  TYLibrary
//
//  Created by Lucca on 2019/2/21.
//

#import "TYAlertViewWindowContainer.h"

@implementation TYAlertViewWindowContainer

- (instancetype)initWithWindow:(UIWindow *)window {
    self = [super init];
    if (self) {
        self.window = window;
    }
    return self;
}

+ (instancetype)containerWithWindow:(UIWindow *)window {
    return [[self alloc] initWithWindow:window];
}

@end
