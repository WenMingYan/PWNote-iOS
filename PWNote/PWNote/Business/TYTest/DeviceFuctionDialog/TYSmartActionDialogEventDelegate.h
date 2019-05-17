//
//  TYDeviceFunctionDialogEventDelegate.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/10.
//  Copyright © 2019 明妍. All rights reserved.
//

#ifndef TYDeviceFunctionDialogEventDelegate_h
#define TYDeviceFunctionDialogEventDelegate_h

#import "TYSmartActionDialogModelProtocol.h"

typedef void(^SingleSelectDialogCallback)(NSInteger index);

/**
 彩色色光 + 饱和度 + 亮度 回调
 
 @param number1 第一个数字
 @param number2 第二个数字
 @param color 颜色值
 */
typedef void(^SliderDialogCSICallback)(double number1,double number2,UIColor *color);
typedef void(^SliderDialogNumCallback)(double number1);
typedef void(^SliderDialogColoursCallback)(double number,UIColor *color);

typedef void(^TimerDialogClickCallback)(NSTimeInterval timer);

@protocol TYSmartActionDialogEventDelegate <NSObject>


@end

#pragma mark - ----------------- 单选接口 -----------------

/** 单选 */
@protocol TYDFSelectorEventDelegate <TYSmartActionDialogEventDelegate>

- (void)dialogSelectIndex:(NSInteger)index;

@end

#pragma mark - ----------------- 滑块接口 -----------------

/** 数字滑块 */
@protocol TYDFNumberSliderEventDelegate <TYSmartActionDialogEventDelegate>
- (void)dialogSliderWithValue:(double)value;
@end

/** 彩色选项滑块 */
@protocol TYDFColoursSliderEventDelegate <TYSmartActionDialogEventDelegate>
- (void)dialogSliderWithNumber:(NSInteger)number andColor:(UIColor *)color;
@end

/** 色彩饱和度滑块 */
@protocol TYDFColoursSaturabilitySliderEventDelegate <TYSmartActionDialogEventDelegate>
- (void)dialogSliderWithNumber:(NSInteger)number andColor:(UIColor *)color;
- (void)dialogSaturabilitySliderWithNumber:(double)number;
@end

/** 色彩饱和度亮度滑块 */
@protocol TYDFColoursSaturabilityIntensitySliderEventDelegate <TYSmartActionDialogEventDelegate>

- (void)dialogSliderWithNumber:(NSInteger)number andColor:(UIColor *)color;
- (void)dialogSaturabilitySliderWithNumber:(double)number;
- (void)dialogIntensitySliderWithNumber:(double)number;

@end

#pragma mark - ----------------- 计时接口 -----------------

@protocol TYDFTimerDialogEventDelegate <TYSmartActionDialogEventDelegate>

- (void)dialogDidClickWithTimer:(NSTimeInterval)timer;

@end

#pragma mark - ----------------- 复杂接口 -----------------

@protocol TYDFCompleteDialogEventDelegate <TYSmartActionDialogEventDelegate>

@optional;

- (void)dialogSelectIndex:(NSInteger)index inPageIndex:(NSInteger)pageIndex;
- (void)dialogSliderWithValue:(double)number inPageIndex:(NSInteger)pageIndex;
- (void)dialogSliderWithColor:(UIColor *)color andColorProgress:(double)progress inPageIndex:(NSInteger)pageIndex;
- (void)dialogSliderWithProgress:(NSInteger)progress andColor:(UIColor *)color inPageIndex:(NSInteger)pageIndex;;

// 色彩饱和度滑块
- (void)dialogColoursSaturabilityWithColor:(UIColor *)color
                             colorProgress:(NSInteger)colorProgress
                         saturabilityValue:(double)number
                               inPageIndex:(NSInteger)pageIndex;
// 色彩饱和度亮度滑块
- (void)dialogColoursSaturabilityWithColor:(UIColor *)color
                             colorProgress:(NSInteger)colorProgress
                         saturabilityValue:(double)saturability
                            intensityValue:(double)intensity
                               inPageIndex:(NSInteger)pageIndex;
@end

#endif /* TYDeviceFunctionDialogEventDelegate_h */
