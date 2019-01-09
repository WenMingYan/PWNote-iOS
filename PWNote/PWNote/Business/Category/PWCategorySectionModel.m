//
//  PWCategorySectionModel.m
//  PWNote
//
//  Created by 明妍 on 2018/12/8.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWCategorySectionModel.h"
#import "PWCagegoryFooterViewModel.h"

@implementation PWCategorySectionModel

@dynamic footerViewModel;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.footerViewModel = [[PWCagegoryFooterViewModel alloc] init];
    }
    return self;
}

@end
