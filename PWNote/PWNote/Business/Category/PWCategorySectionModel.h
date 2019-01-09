//
//  PWCategorySectionModel.h
//  PWNote
//
//  Created by 明妍 on 2018/12/8.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWSectionModel.h"
#import "PWCategoryFooterItemView.h"

@class PWCagegoryFooterViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface PWCategorySectionModel : PWSectionModel

@property (nonatomic, strong) PWCagegoryFooterViewModel<PWViewModelProtocol> *footerViewModel;

@end

NS_ASSUME_NONNULL_END
