//
//  PWInteractor.h
//  PWNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWInteractor : NSObject

- (void)registerTarget:(id)action action:(SEL)select forEventName:(NSString *)eventName;

- (void)sendEventName:(NSString *)eventName withObjects:(id)object;

@end
