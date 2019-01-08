//
//  PWCategoryViewModel.h
//  PWNote
//
//  Created by 明妍 on 2018/12/8.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWViewModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kClickCategoryItem;

@interface PWCategoryViewModel : PWViewModel

- (NSString *)title;

- (NSString *)subTitle;

- (NSString *)number;

- (UIColor *)iconColor;

@end

NS_ASSUME_NONNULL_END
