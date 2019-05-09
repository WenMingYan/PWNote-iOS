//
//  TYDFTimerPickerTableViewCell.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYDFTimerPickerColumnCell : UITableViewCell

@property (nonatomic, weak) UILabel *label;

- (void)transformWith:(CGFloat)angle scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
