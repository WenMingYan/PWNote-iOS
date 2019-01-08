//
//  PWInteractor.m
//  PWNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWInteractor.h"

@interface PWInteractor ()

@property (nonatomic, strong) NSMutableDictionary<NSString *,id<PWAction>> *actionDict;
@property (nonatomic, strong) NSMutableArray *actions;

@end

@implementation PWInteractor

- (void)registerActionName:(NSString *)actionName forAction:(id<PWAction>)action {
    
}

- (void)onActionName:(NSString *)action {
    // do something
}

- (NSMutableDictionary *)actionDict {
    if (!_actionDict) {
        _actionDict = [NSMutableDictionary dictionary];
    }
    return _actionDict;
}

@end
