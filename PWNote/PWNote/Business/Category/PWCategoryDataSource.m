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

@implementation PWCategoryDataSource

- (void)requestWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
#if DEBUG
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        PWCategorySectionModel *sectionModel = [[PWCategorySectionModel alloc] init];
        NSMutableArray *viewModels = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            PWCategoryViewModel *viewModel = [[PWCategoryViewModel alloc] init];
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

@end
