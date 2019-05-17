//
//  TYDFColorSliderView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/10.
//  Copyright © 2019 明妍. All rights reserved.
//  彩色

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"
#import "TYSmartActionDialogEventDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogPaletteSliderView : UIView

@property(nonatomic, copy) SliderDialogColoursCallback block;

@property (nonatomic, strong) id<TYSmartActionDialogColoursModelProtocol> model;/** < 数据Model*/

+ (instancetype)deviceFunctionWithModel:(id<TYSmartActionDialogColoursModelProtocol>)model;
- (instancetype)initWithDeviceFunctionModel:(id<TYSmartActionDialogColoursModelProtocol>)model;


- (UIColor *)colorInProgress:(double)progress;

@end

NS_ASSUME_NONNULL_END
