//
//  TYDeviceFuctionModel.h
//  Pods
//
//  Created by 温明妍 on 2019/5/5.
//

#ifndef TYDeviceFuctionModel_h
#define TYDeviceFuctionModel_h

#import <UIKit/UIKit.h>

/**
 标志接口协议
 */
@protocol TYSmartActionDialogModelProtocol <NSObject>

- (NSString *)dialogTitle;
- (NSString *)dialogIconName;

@end

#pragma mark - ----------------- 单选接口 -----------------

/** 单选接口 */
@protocol TYSmartActionDialogSelectorModelProtocol <TYSmartActionDialogModelProtocol>

- (NSInteger)originalSelectIndex;
/** 单选选项title */
- (NSArray<NSString *> *)dialogOptions;
@optional;

@end


#pragma mark - ----------------- 滑块接口 -----------------

/** 滑块接口 */
@protocol TYDeviceSliderFuctionModelProtocol <TYSmartActionDialogModelProtocol>

@end


typedef enum : NSUInteger {
    TYSmartActionDialogNumberModelType_Temperature, /**< 温度  */
    TYSmartActionDialogNumberModelType_Intensity,/**< 亮度  */
    TYSmartActionDialogNumberModelType_Saturability,/**< 饱和度  */
} TYSmartActionDialogNumberModelType;

/**
 温度 & 亮度 数字相关的Dialog数据
 */
@protocol TYSmartActionDialogNumberModelProtocol <TYDeviceSliderFuctionModelProtocol>

@property (nonatomic, assign) TYSmartActionDialogNumberModelType modelType;

- (double)dialogMax;
- (double)dialogMin;
- (double)dialogStep;
- (double)dialogStartValue;

@end

/**
 彩色色光可以使用该协议
 占位使用
 */
@protocol TYSmartActionDialogColoursModelProtocol <TYDeviceSliderFuctionModelProtocol>

- (double)originalColorProgress;

@end

/** 温度饱和度 */
@protocol TYDDFSliderColoursSaturabilityModelProtocol <TYDeviceSliderFuctionModelProtocol>

- (id<TYSmartActionDialogColoursModelProtocol>)coloursModel;
- (id<TYSmartActionDialogNumberModelProtocol>)saturabilityModel;

@end

/** 温度饱和度亮度 */
@protocol TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol <TYDeviceSliderFuctionModelProtocol>

- (id<TYSmartActionDialogColoursModelProtocol>)coloursModel;
- (id<TYSmartActionDialogNumberModelProtocol>)saturabilityModel;
- (id<TYSmartActionDialogNumberModelProtocol>)intensityModel;

@end

#pragma mark - ----------------- 计时接口 -----------------

typedef enum : NSUInteger {
    TYSmartActionDialogTimerSetType_Minutes,// 精确到分钟，两行
    TYSmartActionDialogTimerSetType_Seconds,// 三行精确到秒, 若不足一小时，则为两行
} TYSmartActionDialogTimerSetType;

/**
 倒计时接口
 */
@protocol TYSmartActionDialogTimerModelProtocol <TYSmartActionDialogModelProtocol>

//TODO: wmy 计时器问题，需要结合之前的做
@property (nonatomic, assign) BOOL hasSetTimer;/** < 是否设定过倒计时*/
@property (nonatomic, assign) TYSmartActionDialogTimerSetType timerSetType;
/**
 倒计时时间
 若为已设定，则为打开选项后的倒计时时间
 若没有设定，该参数为设定的最大小时数(精确到秒)
 */
- (NSTimeInterval)dialogTimer;

@end



//TODO: wmy 工程中已有注意删除 修改独有的
@protocol TYSHDeviceQuickControlItemData <NSObject>

@required
@property (nonatomic, copy) NSString *imageName;    //TODO: 直接传 TYIconfontService iconForKey 转化后的 iconfont 字符串
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *iconColor;
@property (nonatomic, strong) NSNumber *dpId;
@property (nonatomic, assign) BOOL isActive;    // !!!:  没用到
@property (nonatomic, assign) BOOL isOnline;    // !!!:  没用到
@property (nonatomic, assign) BOOL isSwitchDp;  // !!!:  没用到
@property (nonatomic) BOOL isItemEnable;

@end


#endif /* TYDeviceFuctionModel_h */
