//
//  PWCategoryViewModel.m
//  PWNote
//
//  Created by 明妍 on 2018/12/8.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWCategoryViewModel.h"
#import "PWCategoryItemView.h"
#import "PWCategoryModel.h"

@interface PWCategoryViewModel ()

@property (nonatomic, strong) PWCategoryModel *model;

@end

@implementation PWCategoryViewModel

- (Class)itemViewClass {
    return [PWCategoryItemView class];
}

- (CGSize)itemSize {
    return CGSizeMake(kScreenWidth, 44);
}

- (UIColor *)iconColor {
    //TODO: wmy 颜色
    return kThemeColor;
}

- (NSString *)title {
    return self.model.title;
}

- (NSString *)number {
    return @(self.model.number).stringValue;
}


@end
