//
//  TYDFTopCollectionViewCell.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//  查看之前的itemView写法

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogTopCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) BOOL selectCell;

- (void)setItemData:(id<TYSmartActionDialogModelProtocol>)itemData;

@end

NS_ASSUME_NONNULL_END
