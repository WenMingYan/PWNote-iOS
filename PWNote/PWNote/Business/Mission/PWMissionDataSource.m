//
//  PWMissionDataSource.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWMissionDataSource.h"
#import "PWMissionViewModel.h"
#import "PWSectionModel.h"

@interface PWMissionDataSource ()



@end

@implementation PWMissionDataSource

- (void)requestWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
#ifdef DEBUG
    PWSectionModel *sectionModel = [[PWSectionModel alloc] init];
    NSMutableArray<PWMissionViewModel<PWViewModelProtocol> *> *array = [NSMutableArray<PWMissionViewModel<PWViewModelProtocol> *> arrayWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        PWMissionViewModel *mission = [[PWMissionViewModel alloc] init];
        [array addObject:mission];
    }
    sectionModel.viewModels = array;
    self.sectionModels = @[sectionModel];
    if (successBlock) {
        successBlock();
    }
#endif
    //TODO: wmy 连接网络
    
}

@end
