//
//  TYDeviceFunctionDialog.h
//  TYAppleReviewModule-AppleReview
//
//  Created by mingyan on 2019/5/5.
// 组件化选项框
//  视觉地址：https://lanhuapp.com/web/#/item/project/board?pid=94e90a9d-3ae8-49a9-b146-1c073b8e324b&teamId=49c781d5-30fd-4cff-a7ef-42be17d13ac2

#import <Foundation/Foundation.h>
#import "TYSmartActionDialogModelProtocol.h"
#import "TYDeviceFunctionDelegate.h"
#import "TYSmartActionDialogEventDelegate.h"
/**
 设备操作功能组件对话框
 出现方式：底部 + 灰色背景
 消失方式：底部；在需要收起时会有短暂停留（0.35s经验值)，再执行收起动作
 */
@interface TYSmartActionDialog : NSObject
/**
 根据Model实现的Delegate方法，显示Dialog
 */
+ (void)showDialogWithModel:(id<TYSmartActionDialogModelProtocol>)model andDelegate:(id<TYSmartActionDialogEventDelegate>)eventDelegate;

/**
 根据传入的Models显示复杂的Dialog
 */
+ (void)showDialogWithModels:(NSArray<id<TYSmartActionDialogModelProtocol>> *)models andDelegate:(id<TYSmartActionDialogEventDelegate>)eventDelegate;


#pragma mark - ----------------- 单选接口 -----------------
/** 显示单选选项框 */
+ (void)showSelectorDialogWithModel:(id<TYSmartActionDialogSelectorModelProtocol>)model andDelegate:(id<TYDFSelectorEventDelegate>)delegate;
+ (void)showSelectorDialogWithModel:(id<TYSmartActionDialogSelectorModelProtocol>)model callback:(SingleSelectDialogCallback)callback;

#pragma mark - ----------------- 滑块接口 -----------------
/**
 显示数字滑块选项框
 温度、亮度、饱和度选项可以使用该方法创建
 */
+ (void)showSliderNumberDialogWithModel:(id<TYSmartActionDialogNumberModelProtocol>)model
                            andDelegate:(id<TYDFNumberSliderEventDelegate>)delegate;
+ (void)showSliderNumberDialogWithModel:(id<TYSmartActionDialogNumberModelProtocol>)model
                               callback:(SliderDialogNumCallback)callback;

/**
 显示彩色滑块选项框
 */
+ (void)showSliderColoursDialogWithModel:(id<TYSmartActionDialogColoursModelProtocol>)model
                            andDelegate:(id<TYDFColoursSliderEventDelegate>)delegate;
+ (void)showSliderColoursDialogWithModel:(id<TYSmartActionDialogColoursModelProtocol>)model
                               callback:(SliderDialogColoursCallback)callback;

/**
 显示【色彩、饱和度】滑块选项框
 */
+ (void)showColoursSaturabilitySliderDialogWithModel:(id<TYDDFSliderColoursSaturabilityModelProtocol>)model
                                             andDelegate:(id<TYDFColoursSaturabilitySliderEventDelegate>)delegate;
+ (void)showColoursSaturabilitySliderDialogWithModel:(id<TYDDFSliderColoursSaturabilityModelProtocol>)model
                                  andColoursCallback:(SliderDialogColoursCallback)sCallback
                             andSaturabilityCallback:(SliderDialogNumCallback)tCallback;


/**
 显示【色彩、饱和度、亮度】滑块选项框
 */
+ (void)showColoursSaturabilityIntensitySliderDialogWithModel:(id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>)model
                                                  andDelegate:(id<TYDFColoursSaturabilityIntensitySliderEventDelegate>)delegate;
+ (void)showColoursSaturabilityIntensitySliderDialogWithModel:(id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>)model
                                           andColoursCallback:(SliderDialogColoursCallback)cCallback
                                      andSaturabilityCallback:(SliderDialogNumCallback)sCallback
                                         andIntensityCallback:(SliderDialogNumCallback)iCallback;
#pragma mark - ----------------- 计时接口 -----------------
/** 展示计时Dialog */
+ (void)showTimerFunctionDialogWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model
                                andDelegate:(id<TYDFTimerDialogEventDelegate>)delegate;
+ (void)showTimerFunctionDialogWithModel:(id<TYSmartActionDialogTimerModelProtocol>)model
                                   callback:(TimerDialogClickCallback)callback;


@end

