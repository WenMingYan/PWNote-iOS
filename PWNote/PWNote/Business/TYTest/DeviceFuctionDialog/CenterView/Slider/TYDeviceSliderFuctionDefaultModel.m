//
//  TYDeviceSliderFuctionDefaultModel.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYDeviceSliderFuctionDefaultModel.h"

@implementation TYDeviceSliderFuctionDefaultModel
//TODO: wmy to delete
#if DEBUG

- (double)max {
    return 1000;
}
- (double)min {
    return 10;
}
- (double)step {
    return 1;
}

/**
 *  数值型中表示 10 的指数,乘以对应的传输数值,等于实际值,用于避免小数传输
 */
- (NSInteger)scale {
    return 1;
}

- (NSInteger)startValue {
    return 100;
}

- (UIImage *)leftImage {
    return [UIImage new];
}
- (UIImage *)rightImage {
    return [UIImage new];
}

#endif
@end
