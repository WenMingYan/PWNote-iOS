//
//  TYDeviceFunctionBgView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDeviceFuctionModelProtocol.h"

typedef void(^ClickBottomBlock)(void);

//typedef enum : NSUInteger {
//    TYDeviceFunctionBgViewMiddleViewType_SingleSelect,// 单选部分
//    TYDeviceFunctionBgViewMiddleViewType_Slider,//
//    TYDeviceFunctionBgViewMiddleViewType_Complete,
//} TYDeviceFunctionBgViewMiddleViewType;

@interface TYDeviceFunctionView : UIView

//@property (nonatomic, assign) TYDeviceFunctionBgViewTopViewType topViewType;/** < 顶部View类型，主要控制view的高度，默认为Classical*/
@property (nonatomic, assign) TYDFBottomViewType bottomViewType;/** < 底部View类型*/
//@property (nonatomic, assign) TYDeviceFunctionBgViewMiddleViewType middleViewType;/** < 中间View类型*/

//FIXME: 使用强引用是为了让其不被回收
@property (nonatomic, strong) id middleSubViewAgency; /**< 中间展示部分代理  */

@property (nonatomic, strong) UIView *bottomView; /**< 底层部分  */

@property(nonatomic, copy) ClickBottomBlock clickDismissBlock;

/**
 实例化对话框。对话框分为上中下三部分

 @param topView 顶部视图
 @param centerView 中部视图
 @return TYDeviceFunctionView
 */
+ (instancetype)dialogFunctionViewWithTopView:(UIView *)topView
                                   centerView:(UIView *)centerView;

- (instancetype)initDFViewWithTopView:(UIView *)topView
                           centerView:(UIView *)centerView;

@end

