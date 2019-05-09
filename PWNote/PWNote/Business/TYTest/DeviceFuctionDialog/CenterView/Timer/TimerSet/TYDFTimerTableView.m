//
//  TYDFTimerTableView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYDFTimerTableView.h"

@implementation TYDFTimerTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableFooterView = [UIView new];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.scrollsToTop = false;
    }
    return self;
}

@end
