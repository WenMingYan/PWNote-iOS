//
//  TYDFTempColorDefaultSliderModel.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/10.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYSmartActionDialogModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogTempColorSliderDefaultModel : NSObject <TYDDFSliderColoursSaturabilityModelProtocol>

@property (nonatomic, strong) NSString *dialogTitle;
@property (nonatomic, strong) NSString *dialogIconName;
@property (nonatomic, strong) id<TYSmartActionDialogColoursModelProtocol> coloursModel; /**< 色彩  */
@property (nonatomic, strong) id<TYSmartActionDialogNumberModelProtocol> saturabilityModel;

@end

NS_ASSUME_NONNULL_END
