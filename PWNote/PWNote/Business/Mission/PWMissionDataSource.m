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
#import "PWBigTitleViewModel.h"

@interface PWMissionDataSource ()


@end

@implementation PWMissionDataSource

- (void)requestWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
#ifdef DEBUG
    PWSectionModel *sectionModel = [[PWSectionModel alloc] init];
    NSMutableArray<PWViewModel<PWViewModelProtocol> *> *array = [NSMutableArray<PWViewModel<PWViewModelProtocol> *> arrayWithCapacity:10];
    PWBigTitleViewModel *titleModel = [[PWBigTitleViewModel alloc] init];
    titleModel.subTitle = @"副标题";
    titleModel.bigTitle = @"大标题大标题";
    [array addObject:titleModel];
    for (int i = 0; i < 20; i++) {
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
