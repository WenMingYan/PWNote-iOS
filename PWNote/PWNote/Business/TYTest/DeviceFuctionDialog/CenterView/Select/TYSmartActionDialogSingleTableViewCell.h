//
//  TYDeviceFunctionSingleTableViewCell.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//  单选cell

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogSingleTableViewCell : UITableViewCell

- (void)setTitle:(NSString *)title;
@property (nonatomic, assign) BOOL selectCell;

@end

NS_ASSUME_NONNULL_END
