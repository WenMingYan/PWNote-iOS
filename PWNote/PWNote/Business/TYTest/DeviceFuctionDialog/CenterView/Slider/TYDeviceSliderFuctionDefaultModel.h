//
//  TYDeviceSliderFuctionDefaultModel.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYDeviceFuctionModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYDeviceSliderFuctionDefaultModel : NSObject <TYDeviceSliderFuctionModelProtocol>

@property (nonatomic, assign) TYDeviceSliderFuctionModelType modelType;

@end

NS_ASSUME_NONNULL_END
