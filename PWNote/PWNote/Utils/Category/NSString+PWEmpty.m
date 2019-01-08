//
//  NSString+PWEmpty.m
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "NSString+PWEmpty.h"

@implementation NSString (PWEmpty)

-(BOOL)isEmpty {
    if ([self trim].length) {
        return NO;
    }
    return YES;
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
