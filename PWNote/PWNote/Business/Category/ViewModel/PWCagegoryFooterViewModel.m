//
//  PWCagegoryFooterViewModel.m
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWCagegoryFooterViewModel.h"
#import "PWCategoryFooterItemView.h"

@implementation PWCagegoryFooterViewModel

- (Class)itemViewClass {
    return [PWCategoryFooterItemView class];
}

- (CGSize)itemSize {
    return CGSizeMake(kScreenWidth, kSafeArea_Bottom + 50);
}

@end
