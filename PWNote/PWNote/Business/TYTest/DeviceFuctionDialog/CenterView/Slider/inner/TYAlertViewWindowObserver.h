//
//  TYAlertViewWindowObserver.h
//  TYLibrary
//
//  Created by Lucca on 2019/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYAlertViewWindowObserver : NSObject
+ (instancetype)sharedInstance;

- (void)startObserving;
@end

NS_ASSUME_NONNULL_END
