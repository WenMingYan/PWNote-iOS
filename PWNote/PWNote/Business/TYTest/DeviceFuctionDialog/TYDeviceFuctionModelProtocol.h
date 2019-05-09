//
//  TYDeviceFuctionModel.h
//  Pods
//
//  Created by 温明妍 on 2019/5/5.
//

#ifndef TYDeviceFuctionModel_h
#define TYDeviceFuctionModel_h

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TYDFBottomViewType_Arrow,
    TYDFBottomViewType_CencelButton,
    TYDFBottomViewType_StartButton,
} TYDFBottomViewType;

/**
 标志接口协议
 */
@protocol TYDeviceFuctionModelProtocol <NSObject>

@end

/**
 单选接口
 */
@protocol TYDFSingleSectionModelProtocol <TYDeviceFuctionModelProtocol>

@property (nonatomic, assign, getter=isSelect) BOOL select;

- (NSString *)title;

@end

typedef enum : NSUInteger {
    TYDeviceSliderFuctionModelType_Temperature,// 温度
    TYDeviceSliderFuctionModelType_Intensity,// 亮度
    TYDeviceSliderFuctionModelType_MonochromaticLight,// 单色光
    TYDeviceSliderFuctionModelType_Colorful,// 彩色色光
} TYDeviceSliderFuctionModelType;

/**
 滑块接口
 */
@protocol TYDeviceSliderFuctionModelProtocol <TYDeviceFuctionModelProtocol>


/** < 滑块调节样式*/
- (TYDeviceSliderFuctionModelType)modelType;

- (double)max;
- (double)min;
- (double)step;

/**
 //TODO: wmy 这里需要弄清楚scale的意义
 *  数值型中表示 10 的指数,乘以对应的传输数值,等于实际值,用于避免小数传输
 */
- (NSInteger)scale;

- (NSInteger)startValue;


@end



//TODO: wmy 按钮的配置
typedef enum : NSUInteger {
    TYDFTimerButtonType_Start,
    TYDFTimerButtonType_Cancel,
} TYDFTimerButtonType;

typedef enum : NSUInteger {
    TYDFTimerSetType_Minutes,// 精确到分钟，两行
    TYDFTimerSetType_Seconds,// 三行精确到秒, 若不足一小时，则为两行
} TYDFTimerSetType;
/**
 倒计时接口
 */
@protocol TYDFTimerModelProtocol <TYDeviceFuctionModelProtocol>

//TODO: wmy 计时器问题，需要结合之前的做
@property (nonatomic, assign) BOOL hasSet;/** < 是否设定过倒计时*/
@property (nonatomic, assign) TYDFTimerSetType timerSetType;
/**
 倒计时时间
 若为已设定，则为打开选项后的倒计时时间
 若没有设定，该参数为设定的最大小时数(精确到秒)
 */
- (NSTimeInterval)timer;

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

//TODO: wmy dataSource
@protocol TYDeviceFunctionDelegate <NSObject>
/**
 复杂对话框的头部数据
 */
- (NSArray <id<TYSHDeviceQuickControlItemData>> *)dialogTitleDatas;

//TODO: wmy 传入对应的type 回调时给index值
/**
 主体显示部分，与头部数据长度一致，否则debug下直接crash，release下白屏
 */
- (NSArray <UIView *> *)centerViewDatas;

- (TYDFBottomViewType)bottomType;
//@optional;
//// 当内部存在单选时会调用此方法
//- (void)dialogSingleSelectWithIndex:(NSInteger)index andModel:(id<TYDFSingleSectionModelProtocol>)model;
//// 当内部存在滑动时会调用此方法
//- (void)dialogSliderInNumber:(double)number andColor:(UIColor *)color;
//
//- (void)dialogTimerSetWithTimer:(NSTimeInterval)timer;
//// 当内部存在倒计时，且点击取消时调用此方法
//- (void)dialogCancelTimerWithTimer:(BOOL)success;

@end

#endif /* TYDeviceFuctionModel_h */
