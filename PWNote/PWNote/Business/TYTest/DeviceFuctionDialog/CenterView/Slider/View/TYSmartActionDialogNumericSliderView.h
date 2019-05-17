//
//  TYQuickOpValueSliderView.h
//  TuyaSmartPublic
//
//  Created by 高森 on 2017/1/9.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"
#import "TPSlider.h"

typedef void(^ValueBlock)(double number);

@interface TYSmartActionDialogNumericSliderView : UIView

@property(nonatomic, copy) ValueBlock block;
@property (nonatomic, strong) id<TYSmartActionDialogNumberModelProtocol> model;/** < 数据Model*/

+ (instancetype)deviceFunctionWithModel:(id<TYSmartActionDialogNumberModelProtocol>)model;
- (instancetype)initWithDeviceFunctionModel:(id<TYSmartActionDialogNumberModelProtocol>)model;

@end
