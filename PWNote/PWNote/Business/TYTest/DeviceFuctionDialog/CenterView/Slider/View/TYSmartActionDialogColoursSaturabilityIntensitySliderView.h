//
//  TYDFColoursSaturabilityIntensitySliderView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"
#import "TYSmartActionDialogEventDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogColoursSaturabilityIntensitySliderView : UIView

@property (nonatomic, strong) id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol> model;

@property(nonatomic, copy) SliderDialogColoursCallback coloursCallback;
@property(nonatomic, copy) SliderDialogNumCallback saturabilityCallback;
@property(nonatomic, copy) SliderDialogNumCallback intensityCallback;

- (instancetype)initSliderViewWithModel:(id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>)model;
+ (instancetype)sliderViewWithModel:(id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>)model;



- (UIColor *)colorInProgress:(double)progress;

@end

NS_ASSUME_NONNULL_END
