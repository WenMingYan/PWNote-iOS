//
//  TYQuickOpValueSliderView.h
//  TuyaSmartPublic
//
//  Created by 高森 on 2017/1/9.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDeviceFuctionModelProtocol.h"
#import "TPSlider.h"

//#import "TYIconfontService.h"
typedef void(^ValueBlock)(double number,UIColor *colorBlock);
//typedef void(^ColorBlock)(UIColor *colorBlock);

@protocol TYQuickOpContentViewDelegate <NSObject>

//- (void)quickOpViewDoneAction:(TYQuickOpContentView *)view;
//- (void)quickOpView:(TYQuickOpContentView *)view publishDps:(NSDictionary *)dps;


@end


@interface TYDFSliderView : UIView

//- (instancetype)initWithDevice:(TuyaSmartDeviceModel *)device schema:(TuyaSmartSchemaModel *)schema startValue:(NSInteger)startValue;
@property(nonatomic, weak) id<TYQuickOpContentViewDelegate> delegate;

@property(nonatomic, copy) ValueBlock block;
//@property(nonatomic, copy) ColorBlock colorBlock;

//TODO: wmy 入口
+ (instancetype)deviceFunctionWithModel:(id<TYDeviceSliderFuctionModelProtocol>)model;
- (instancetype)initWithDeviceFunctionModel:(id<TYDeviceSliderFuctionModelProtocol>)model;



- (void)updateValueLabel;

@end
