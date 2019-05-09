//
//  TYAlertViewWindowContainer.h
//  TYLibrary
//
//  Created by Lucca on 2019/2/21.
//

#import <UIKit/UIKit.h>

@interface TYAlertViewWindowContainer : NSObject
- (instancetype)initWithWindow:(UIWindow *)window;

+ (instancetype)containerWithWindow:(UIWindow *)window;

@property (weak, nonatomic) UIWindow *window;
@end
