//
//  TYAlertViewTextFiled.m
//  TYLibrary
//
//  Created by Lucca on 2019/2/21.
//

#import "TYAlertViewTextField.h"
#import "TYAlertView.h"

@implementation TYAlertViewTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds.origin.x += TYAlertViewPaddingWidth;
    bounds.size.width -= TYAlertViewPaddingWidth * 2.0;
    
    if (self.leftView) {
        bounds.origin.x += CGRectGetWidth(self.leftView.bounds) + TYAlertViewPaddingWidth;
        bounds.size.width -= CGRectGetWidth(self.leftView.bounds) + TYAlertViewPaddingWidth;
    }
    
    if (self.rightView) {
        bounds.size.width -= CGRectGetWidth(self.rightView.bounds) + TYAlertViewPaddingWidth;
    }
    else if (self.clearButtonMode == UITextFieldViewModeAlways) {
        bounds.size.width -= 20.0;
    }
    
    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds.origin.x += TYAlertViewPaddingWidth;
    bounds.size.width -= TYAlertViewPaddingWidth * 2.0;
    
    if (self.leftView) {
        bounds.origin.x += CGRectGetWidth(self.leftView.bounds) + TYAlertViewPaddingWidth;
        bounds.size.width -= CGRectGetWidth(self.leftView.bounds) + TYAlertViewPaddingWidth;
    }
    
    if (self.rightView) {
        bounds.size.width -= CGRectGetWidth(self.rightView.bounds) + TYAlertViewPaddingWidth;
    }
    else if (self.clearButtonMode == UITextFieldViewModeAlways) {
        bounds.size.width -= 20.0;
    }
    
    return bounds;
}


@end
