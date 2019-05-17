//
//  TYDFTimerBaseView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/10.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickBottomBlock)(void);

@interface TYSmartActionDialogTimerBaseView : UIView

@property(nonatomic, copy) ClickBottomBlock clickBottomBlock;
@property (nonatomic, assign) NSTimeInterval timer;

- (instancetype)initTimerViewWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model;
+ (instancetype)timerViewWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model;

@property (nonatomic, strong) id<TYSmartActionDialogTimerModelProtocol> model; /**< 数据 */

@end

NS_ASSUME_NONNULL_END
