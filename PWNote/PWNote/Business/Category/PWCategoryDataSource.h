//
//  PWCategoryDataSource.h
//  PWNote
//
//  Created by 明妍 on 2018/12/6.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWDataSource.h"
#import "PWCategoryUserViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWCategoryDataSource : PWDataSource

@property (nonatomic, strong) PWCategoryUserViewModel *userViewModel; /**< 用户信息  */

@end

NS_ASSUME_NONNULL_END
