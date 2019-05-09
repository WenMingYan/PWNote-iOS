//
//  TYAlertViewController.h
//  TYLibrary
//
//  Created by Lucca on 2019/1/17.
//

#import <UIKit/UIKit.h>
#import "TYAlertView.h"

@interface TYAlertViewController : UIViewController
- (nonnull instancetype)initWithAlertView:(nonnull TYAlertView *)alertView view:(nonnull UIView *)view;
@end

