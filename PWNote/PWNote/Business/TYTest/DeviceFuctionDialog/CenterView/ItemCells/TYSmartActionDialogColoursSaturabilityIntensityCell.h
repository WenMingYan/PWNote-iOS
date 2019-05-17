//
//  TYDFColoursSaturabilityInCell.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogEventDelegate.h"
#import "TYSmartActionDialogModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogColoursSaturabilityIntensityCell : UICollectionViewCell

@property(nonatomic, weak) id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol> model;

@property (nonatomic, assign) double saturabilityValue;
@property (nonatomic, assign) double intensityValue;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) double colorProgress;

- (void)setColoursCallback:(SliderDialogColoursCallback)coloursCallback;
- (void)setSaturabilityCallback:(SliderDialogNumCallback)saturabilityCallback;
- (void)setIntensityCallback:(SliderDialogNumCallback)intensityCallback;

@end

NS_ASSUME_NONNULL_END
