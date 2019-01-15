//
//  PWBigTitleViewModel.m
//  PWNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWBigTitleViewModel.h"
#import "PWBigTitleView.h"

CGFloat const kBigTitleViewHeight = 200;
NSString * const kClickBigTitleLabelEvent = @"kClickBigTitleLabelEvent";
NSString * const kTitleLabelEndEditingEvent = @"kTitleLabelEndEditingEvent";

@implementation PWBigTitleViewModel


- (CGSize)itemSize {
    return CGSizeMake(kScreenWidth, kBigTitleViewHeight);
}

- (Class)itemViewClass {
    return [PWBigTitleView class];
}

@end
