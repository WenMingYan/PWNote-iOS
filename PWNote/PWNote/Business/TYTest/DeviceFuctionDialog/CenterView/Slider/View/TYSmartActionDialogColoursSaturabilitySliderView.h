//
//  TYDFColoursSliderView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/10.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"
#import "TYSmartActionDialogEventDelegate.h"
//TODO: wmy 当选中某个时需要渐变色

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogColoursSaturabilitySliderView : UIView

@property (nonatomic, strong) id<TYDDFSliderColoursSaturabilityModelProtocol> model;

+ (instancetype)silderViewWithModel:(id<TYDDFSliderColoursSaturabilityModelProtocol>)model;
- (instancetype)initSilderViewWithModel:(id<TYDDFSliderColoursSaturabilityModelProtocol>)model;

@property(nonatomic, copy) SliderDialogColoursCallback coloursCallback;
@property(nonatomic, copy) SliderDialogNumCallback saturabilityCallback;

- (UIColor *)colorInProgress:(double)progress;

@end

NS_ASSUME_NONNULL_END
