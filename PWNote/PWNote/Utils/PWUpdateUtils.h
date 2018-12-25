//
//  PWUpdateUtils.h
//  PWNote
//
//  Created by mingyan on 2018/12/25.
//  Copyright © 2018 明妍. All rights reserved.
//  用于升级

#import <Foundation/Foundation.h>

@interface PWUpdateUtils : NSObject

+ (void)checkUpdateWithSuccess:(void(^)(BOOL canUpdate,NSString *updateAdd))success fail:(void(^)(NSError *err))error;

@end
