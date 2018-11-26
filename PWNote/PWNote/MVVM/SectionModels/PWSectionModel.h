//
//  PWSectionModel.h
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWSectionModelProtocol.h"
#import "PWViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWSectionModel : NSObject <PWSectionModelProtocol>

@property (nonatomic, strong) NSArray<PWViewModel<PWViewModelProtocol> *> *viewModels;

@end

NS_ASSUME_NONNULL_END
