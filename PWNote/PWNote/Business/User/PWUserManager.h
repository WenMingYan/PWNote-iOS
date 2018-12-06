//
//  PWUserManager.h
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWUser.h"

typedef void(^LoginBlock)(BOOL success);

extern NSString const * kUserChangedNotification;

NS_ASSUME_NONNULL_BEGIN

@interface PWUserManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isLogin;

- (PWUser *)user;

- (void)loginInWithUserName:(NSString *)userName password:(NSString *)password withComplementation:(LoginBlock)complementationBlock;


@end

NS_ASSUME_NONNULL_END
