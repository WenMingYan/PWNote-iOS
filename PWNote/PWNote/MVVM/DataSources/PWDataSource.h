//
//  PWDataSource.h
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWSectionModel.h"
#import "PWViewModel.h"

typedef void(^SuccessBlock)(void);
typedef void(^FailBlock)(NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface PWDataSource : NSObject

@property (nonatomic, strong) NSString *method;

@property (nonatomic, strong) NSArray<PWSectionModel<PWSectionModelProtocol> *> *sectionModels;

- (void)requestWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

- (PWViewModel *)viewModelWithIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
