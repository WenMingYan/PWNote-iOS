//
//  TYDFSliderCollectionView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogEventDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogNumberSliderCell : UICollectionViewCell

@property(nonatomic, copy) SliderDialogNumCallback callback;
@property(nonatomic, weak) id<TYSmartActionDialogNumberModelProtocol> model;

@end

NS_ASSUME_NONNULL_END
