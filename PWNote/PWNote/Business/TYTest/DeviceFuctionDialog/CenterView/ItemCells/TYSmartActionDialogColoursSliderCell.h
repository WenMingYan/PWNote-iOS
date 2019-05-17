//
//  TYDFColoursSliderCell.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"
#import "TYSmartActionDialogEventDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogColoursSliderCell : UICollectionViewCell

@property(nonatomic, weak) id<TYSmartActionDialogColoursModelProtocol> model;

- (void)setBlock:(SliderDialogColoursCallback)block;

@end

NS_ASSUME_NONNULL_END
