//
//  TYDDFSliderColoursSaturabilityIntensityDefaultModel.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYSmartActionDialogModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogSliderColoursSaturabilityIntensityDefaultModel : NSObject <TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>

@property (nonatomic, strong) NSString *dialogTitle;
@property (nonatomic, strong) NSString *dialogIconName;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) id<TYSmartActionDialogColoursModelProtocol> coloursModel; /**< 色彩  */
@property (nonatomic, strong) id<TYSmartActionDialogNumberModelProtocol> saturabilityModel; /**< 饱和度  */
@property (nonatomic, strong) id<TYSmartActionDialogNumberModelProtocol> intensityModel;/**< 亮度  */

@end

NS_ASSUME_NONNULL_END
