//
//  TYDFSimpleTitleView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/9.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYDFSimpleTitleLabel.h"
#import "TYDeviceFunctionDefine.h"

@implementation TYDFSimpleTitleLabel

+ (instancetype)simpleTitleView {
    TYDFSimpleTitleLabel *label = [[TYDFSimpleTitleLabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = HEXCOLORA(0x81828B, 1.0);
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    return label;
}


@end
