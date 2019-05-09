//
//  TYDeviceFunctionDialog.h
//  TYAppleReviewModule-AppleReview
//
//  Created by mingyan on 2019/5/5.
// 组件化选项框
//  视觉地址：https://lanhuapp.com/web/#/item/project/board?pid=94e90a9d-3ae8-49a9-b146-1c073b8e324b&teamId=49c781d5-30fd-4cff-a7ef-42be17d13ac2

#import <Foundation/Foundation.h>
#import "TYDeviceFuctionModelProtocol.h"

typedef void(^SingleSelectDialogCallback)(id<TYDFSingleSectionModelProtocol> model,NSInteger index);
// 滑动回调，当组件使用温度和的亮度控制时，color为nil
typedef void(^SliderDialogCallback)(double number,UIColor *color);
// 设定时间回调
typedef void (^TimerSetDialogCallback)(NSTimeInterval timer);
// 取消设定回调
typedef void (^TimerCancelDialogCallback)(void);


/**
 设备操作功能组件对话框
 出现方式：底部 + 灰色背景
 消失方式：底部；在需要收起时会有短暂停留（0.35s经验值)，再执行收起动作
 */
@interface TYDeviceFunctionDialog : NSObject

/**
 显示单选选项框
 
 @param title 标题
 @param actions 单选选项配置
 @param callback 参数选择回调
 */
+ (void)showSingleSelectFunctionDialogWithTitle:(NSString *)title
                                  selectActions:(NSArray <id<TYDFSingleSectionModelProtocol>>*) actions
                                       callback:(SingleSelectDialogCallback)callback;


/**
 显示滑块选项框

 @param title 标题
 @param model 滑块配置参数Model
 @param callback 滑块配置完毕回调
 */
+ (void)showSliderFuctionDialogWithTitle:(NSString *)title
                             sliderModel:(id<TYDeviceSliderFuctionModelProtocol>)model
                                callback:(SliderDialogCallback)callback;

/**
 显示定时器设置选项框
 需要model中hasSet为false，显示计时选项，其中model.timer为倒计时的最大时间

 @param title 标题
 @param model 配置参数Model
 @param callback 回调
 //TODO: wmy 调研app中定时器回调的形式
 */
+ (void)showTimerSetFunctionDialogWithTitle:(NSString *)title
                                 timerModel:(id<TYDFTimerModelProtocol>)model
                                   callback:(TimerSetDialogCallback)callback;

/**
 显示定时器倒计时选项框，仅有"Cancel"可以操作
 需要model中hasSet为True，显示倒计时，其中model.timer为倒计时打开时倒计时的时间

 @param title 标题
 @param model 配置参数Model
 @param callback 回调
 */
+ (void)showTimerFunctionDialogWithTitle:(NSString *)title
                              timerModel:(id<TYDFTimerModelProtocol>)model
                                callback:(TimerCancelDialogCallback)callback;


/**
 显示负责对话选项框
 */
+ (void)showCompleteFunctionDialogWithDelegate:(id<TYDeviceFunctionDelegate>)delegate;


@end

