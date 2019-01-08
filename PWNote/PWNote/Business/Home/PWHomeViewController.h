//
//  PWHomeViewController.h
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//  主页

#import "PWBigTitleTableViewController.h"
#import "PWUtils.h"

@class PWCategoryViewModel;

@interface PWHomeViewController : PWBigTitleTableViewController

- (void)onClickCategory;

- (void)updateCategory:(PWCategoryViewModel *)viewModel;

@end
