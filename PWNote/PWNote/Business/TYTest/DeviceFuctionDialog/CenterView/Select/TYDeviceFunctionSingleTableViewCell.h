//
//  TYDeviceFunctionSingleTableViewCell.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//  单选cell

#import <UIKit/UIKit.h>
#import "TYDeviceFuctionModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYDeviceFunctionSingleTableViewCell : UITableViewCell

@property(nonatomic, weak) id<TYDFSingleSectionModelProtocol> model;/**< 数据Data  */

@end

NS_ASSUME_NONNULL_END
