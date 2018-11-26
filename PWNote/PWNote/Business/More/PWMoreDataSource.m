//
//  PWMoreDataSource.m
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWMoreDataSource.h"

@interface PWMoreDataSource ()

@property (nonatomic, strong) PWSectionModel *commonSectionModel; /**< 通用  */
@property (nonatomic, strong) PWSectionModel *moreSectionModel; /**< 更多  */

@end

@implementation PWMoreDataSource

- (PWSectionModel *)commonSectionModel {
    if (!_commonSectionModel) {
        _commonSectionModel = [[PWSectionModel alloc] init];
        
    }
    return _commonSectionModel;
}

@end
