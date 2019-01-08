//
//  PWCategoryUserViewModel.m
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWCategoryUserViewModel.h"
#import "PWUserManager.h"

@implementation PWCategoryUserViewModel

- (CGSize)itemSize {
    return CGSizeMake(kScreenWidth, 60 + kSafeAreaStatusBarHeight);
}

- (NSString *)iconImageUrl {
    return [PWUserManager sharedInstance].user.iconImageUrl;
}

- (NSString *)userName {
    return [PWUserManager sharedInstance].user.userName;
}

@end
