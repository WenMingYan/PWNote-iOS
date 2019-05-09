//
//  TYAlertShadowView.h
//  TYLibrary
//
//  Created by Lucca on 2019/2/19.
//

#import <UIKit/UIKit.h>



@interface TYAlertShadowView : UIView

@property (assign, nonatomic) CGFloat cornerRadius;
@property (strong, nonatomic, nullable) UIColor *strokeColor;
@property (assign, nonatomic) CGFloat strokeWidth;
@property (strong, nonatomic, nullable) UIColor *shadowColor;
@property (assign, nonatomic) CGFloat shadowBlur;
@property (assign, nonatomic) CGPoint shadowOffset;

@end

