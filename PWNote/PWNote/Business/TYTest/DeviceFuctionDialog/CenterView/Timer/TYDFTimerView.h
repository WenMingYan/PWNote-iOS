//
//  TYDFTimerView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDeviceFuctionModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickBottomBlock)(void);

@interface TYDFTimerView : UIView

//TODO: wmy 屏蔽直接init
- (instancetype)initTimerViewWithModel:(id<TYDFTimerModelProtocol>)model;
+ (instancetype)timerViewWithModel:(id<TYDFTimerModelProtocol>)model;

@property (nonatomic, assign) NSTimeInterval timer;/** < 选中的时间*/

@property(nonatomic, copy) ClickBottomBlock clickBottomBlock;

@end

NS_ASSUME_NONNULL_END
