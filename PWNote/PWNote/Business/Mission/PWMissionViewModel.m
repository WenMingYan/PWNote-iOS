//
//  PWMissionViewModel.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWMissionViewModel.h"

@implementation PWMissionViewModel

- (Class)itemViewClass {
    return NSClassFromString(@"PWMissionItemView");
}

- (CGSize)itemSize {
    return CGSizeMake(kScreenWidth, 40);
}

- (NSString *)title {
    NSIndexPath *indexPath = self.indexPath;
    return [NSString stringWithFormat:@"标题标题 - %ld",(long)self.indexPath.row];
}

@end
