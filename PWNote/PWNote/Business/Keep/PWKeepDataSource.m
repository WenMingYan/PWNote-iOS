//
//  PWKeepDataSource.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWKeepDataSource.h"
#import "PWKeepViewModel.h"

@implementation PWKeepDataSource

- (void)requestWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
#ifdef DEBUG
    PWSectionModel *sectionModel = [[PWSectionModel alloc] init];
    NSMutableArray<PWKeepViewModel<PWViewModelProtocol> *> *array =
    [NSMutableArray<PWKeepViewModel<PWViewModelProtocol> *> arrayWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        PWKeepViewModel *keep = [[PWKeepViewModel alloc] init];
        [array addObject:keep];
    }
    sectionModel.viewModels = array;
    self.sectionModels = @[sectionModel];
    if (successBlock) {
        successBlock();
    }
#endif
}

@end
