//
//  TYDFSingleCollectionCell.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"
#import "TYSmartActionDialogTableViewAgency.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogSingleCell : UICollectionViewCell

@property(nonatomic, weak) id<TYSmartActionDialogSelectorModelProtocol> model;
- (void)setSelectItemBlock:(SelectItemBlock)selectItemBlock;

@end

NS_ASSUME_NONNULL_END
