//
//  PWCategoryModel.h
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PWCategoryModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) NSString *iconColor;

@end

NS_ASSUME_NONNULL_END
