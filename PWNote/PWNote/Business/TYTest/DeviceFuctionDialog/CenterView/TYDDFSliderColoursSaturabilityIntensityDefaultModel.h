//
//  TYDDFSliderColoursSaturabilityIntensityDefaultModel.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYDeviceFuctionModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYDDFSliderColoursSaturabilityIntensityDefaultModel : NSObject

@property (nonatomic, strong) id<TYDeviceSliderFuctionColoursModelProtocol> coloursModel; /**< 色彩  */
@property (nonatomic, strong) id<TYDeviceSliderFuctionNumberModelProtocol> saturabilityModel; /**< 饱和度  */
@property (nonatomic, strong) id<TYDeviceSliderFuctionNumberModelProtocol> intensityModel; /**< 亮度  */

@end

NS_ASSUME_NONNULL_END
