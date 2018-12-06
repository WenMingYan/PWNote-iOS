//
//  PWSettingViewModel.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWSettingViewModel.h"

@implementation PWSettingViewModel

- (CGSize)itemSize {
    return CGSizeMake(kScreenWidth, 44);
}

- (Class)itemViewClass {
    return NSClassFromString(@"PWSettingItemView");
}

@end
