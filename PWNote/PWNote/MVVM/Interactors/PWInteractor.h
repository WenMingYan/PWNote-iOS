//
//  PWInteractor.h
//  PWNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PWAction <NSObject>


@end

@interface PWInteractor : NSObject

- (void)registerActionName:(NSString *)actionName forAction:(id<PWAction>)action;

- (void)onActionName:(NSString *)action;

@end
