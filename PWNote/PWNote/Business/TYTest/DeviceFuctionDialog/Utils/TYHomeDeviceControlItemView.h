//
//  TYHomeDeviceControlItemView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDeviceFuctionModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface TYHomeDeviceControlItemView : UIView

@property (nonatomic, strong) id<TYSHDeviceQuickControlItemData> itemData;

@property (nonatomic, strong) UILabel *iconLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *valueLabel;


@end

NS_ASSUME_NONNULL_END
