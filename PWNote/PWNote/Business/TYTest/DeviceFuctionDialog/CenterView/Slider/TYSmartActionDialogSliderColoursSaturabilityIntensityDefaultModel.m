//
//  TYDDFSliderColoursSaturabilityIntensityDefaultModel.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogSliderColoursSaturabilityIntensityDefaultModel.h"

@implementation TYSmartActionDialogSliderColoursSaturabilityIntensityDefaultModel


- (id<TYSmartActionDialogColoursModelProtocol>)coloursModel {
    return _coloursModel;
}

- (id<TYSmartActionDialogNumberModelProtocol>)intensityModel {
    return _intensityModel;
}

- (id<TYSmartActionDialogNumberModelProtocol>)saturabilityModel {
    return _saturabilityModel;
}

@end
