//
//  PWDataSource.m
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWDataSource.h"

@implementation PWDataSource

- (void)requestWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    
}

- (PWViewModel *)viewModelWithIndexPath:(NSIndexPath *)indexPath {
    if (!self.sectionModels.count) {
        return nil;
    }
    if (indexPath.section < self.sectionModels.count) {
        id<PWSectionModelProtocol> sectionModel = [self.sectionModels objectAtIndex:indexPath.section];
        if (!sectionModel.viewModels.count) {
            return nil;
        }
        if (indexPath.row < sectionModel.viewModels.count) {
            id<PWViewModelProtocol> viewModel = (id<PWViewModelProtocol>)[sectionModel.viewModels objectAtIndex:indexPath.row];
            return viewModel;
        }
    }
    return nil;
}

@end
