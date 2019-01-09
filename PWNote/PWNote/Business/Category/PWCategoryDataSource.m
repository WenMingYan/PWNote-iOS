//
//  PWCategoryDataSource.m
//  PWNote
//
//  Created by 明妍 on 2018/12/6.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWCategoryDataSource.h"
#import "PWCategorySectionModel.h"
#import "PWCategoryViewModel.h"
#import "PWCategoryModel.h"
#import "PWCagegoryFooterViewModel.h"

@implementation PWCategoryDataSource

- (void)requestWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
#if DEBUG
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        PWCategorySectionModel *sectionModel = [[PWCategorySectionModel alloc] init]; 
        NSMutableArray *viewModels = [NSMutableArray array];
        for (int j = 0; j < 5; j++) {
            PWCategoryModel *model = [[PWCategoryModel alloc] init];
            model.title = [NSString stringWithFormat:@"大标题 (%d, %d)",i,j];
            model.number = 3;
            model.iconColor = @"#000000";
            PWCategoryViewModel *viewModel = [[PWCategoryViewModel alloc] init];
            viewModel.model = model;
            [viewModels addObject:viewModel];
        }
        sectionModel.viewModels = viewModels;
        [array addObject:sectionModel];
    }
    self.sectionModels = array;
    
    if (successBlock) {
        successBlock();
    }
#endif
}

- (PWCategoryUserViewModel *)userViewModel {
    if (!_userViewModel) {
        _userViewModel = [[PWCategoryUserViewModel alloc] init];
    }
    return _userViewModel;
}

@end
