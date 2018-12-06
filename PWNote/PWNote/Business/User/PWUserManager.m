//
//  PWUserManager.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWUserManager.h"
#import "PWNetworkService.h"
#import "PWUser.h"

NSString const * kUserChangedNotification = @"kUserChangedNotification";

@interface PWUserManager ()

@property (nonatomic, strong) PWUser *user;

@end

@implementation PWUserManager

static PWUserManager *__onetimeClass;
+ (instancetype)sharedInstance {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        __onetimeClass = [[PWUserManager alloc] init];
    });
    return __onetimeClass;
}

- (BOOL)isLogin {
    if (self.user) {
        return YES;
    }
    return NO;
}

- (void)loginInWithUserName:(NSString *)userName
                   password:(NSString *)password
        withComplementation:(LoginBlock)complementationBlock {
    
    PWNetworkService *service = [[PWNetworkService alloc] init];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userName"] = userName;
    param[@"password"] = password;
    [service postRequestWithMethod:@"login" withParam:param success:^(NSDictionary * _Nonnull param) {
        //TODO: wmy
        if (complementationBlock) {
            complementationBlock(YES);
        }
    } fail:^(NSError * _Nonnull error) {
        if (complementationBlock) {
            complementationBlock(NO);
        }
    }];
}

@end
