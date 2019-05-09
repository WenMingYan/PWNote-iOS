//
//  PWInteractor.m
//  PWNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWInteractor.h"
#import "NSString+PWEmpty.h"
#import "PWUtils.h"

@interface PWInteractorModel : NSObject
@property (nonatomic, strong) NSString *eventName; /**< 响应名称  */
@property (nonatomic, weak) id target; /**< 响应体  */
@property (nonatomic, assign) SEL selector;/** < 响应的方法*/

@end

@implementation PWInteractorModel


@end

@interface PWInteractor ()

@property (nonatomic, strong) NSMutableDictionary<NSString */* eventName */,PWInteractorModel *> *actionDict;

@end

@implementation PWInteractor

- (void)registerTarget:(id)target action:(SEL)select forEventName:(NSString *)eventName {
    if (!eventName.isEmpty && ![self.actionDict.allKeys containsObject:eventName]) {
        PWInteractorModel *model = [[PWInteractorModel alloc] init];
        model.target = target;
        model.selector = select;
        self.actionDict[eventName] = model;
    }
}

- (void)sendEventName:(NSString *)eventName withObjects:(id)object {
    // do something
    if (eventName.isEmpty || ![self.actionDict.allKeys containsObject:eventName]) {
        return;
    }
    PWInteractorModel *model = self.actionDict[eventName];
    if (model && model.target && model.selector &&
        [model.target respondsToSelector:model.selector]) {
        SuppressPerformSelectorLeakWarning(
            [model.target performSelector:model.selector withObject:object];
                                           );
        
    }
}

- (NSMutableDictionary *)actionDict {
    if (!_actionDict) {
        _actionDict = [NSMutableDictionary dictionary];
    }
    return _actionDict;
}

@end
