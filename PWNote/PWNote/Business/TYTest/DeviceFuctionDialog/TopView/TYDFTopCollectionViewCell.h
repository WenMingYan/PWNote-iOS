//
//  TYDFTopCollectionViewCell.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDeviceFuctionModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYDFTopCollectionViewCell : UICollectionViewCell

- (void)setItemData:(id<TYSHDeviceQuickControlItemData>)itemData;

@end

NS_ASSUME_NONNULL_END
