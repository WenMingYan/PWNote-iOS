//
//  TYDeviceFunctionDelegate.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/10.
//  Copyright © 2019 明妍. All rights reserved.
//

#ifndef TYDeviceFunctionDelegate_h
#define TYDeviceFunctionDelegate_h

@protocol TYDeviceFunctionDelegate <NSObject>

- (void)dialogTimerSetWithTimer:(NSTimeInterval)timer;
// 当内部存在倒计时，且点击取消时调用此方法
- (void)dialogCancelTimerWithTimer:(BOOL)success;

@end

@protocol TYDeviceFunctionSingleSelectDelegate <TYDeviceFunctionDelegate>

- (void)dialogSingleSelectWithIndex:(NSInteger)index andModel:(id<TYSmartActionDialogSelectorModelProtocol>)model;

@end

@protocol TYDeviceFunctionSliderInNumberSelectDelegate <TYDeviceFunctionDelegate>

// 当内部存在滑动时会调用此方法
- (void)dialogSliderInNumber:(double)number andColor:(UIColor *)color;

@end

#endif /* TYDeviceFunctionDelegate_h */
