//
//  TYDFColoursSaturabilityCell.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"
#import "TYSmartActionDialogEventDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogColoursSaturabilityCell : UICollectionViewCell

@property(nonatomic, weak) id<TYDDFSliderColoursSaturabilityModelProtocol> model;

@property (nonatomic, assign) double saturabilityValue;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) double colorProgress;

- (void)setColoursCallback:(SliderDialogColoursCallback)coloursCallback;
- (void)setSaturabilityCallback:(SliderDialogNumCallback)saturabilityCallback;

@end


NS_ASSUME_NONNULL_END
