//
//  TYDFTimerCell.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogTimerCell : UICollectionViewCell

@property(nonatomic, weak) id<TYSmartActionDialogTimerModelProtocol> model;

@end

NS_ASSUME_NONNULL_END
