//
//  PWInteractor.m
//  PWNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWInteractor.h"

@interface PWInteractorModel : NSObject
@property (nonatomic, strong) NSString *eventName; /**< 响应名称  */
@property (nonatomic, weak) id<PWAction> target; /**< 响应体  */
@property (nonatomic, assign) SEL selector;/** < 响应的方法*/

@end

@implementation PWInteractorModel


@end

@interface PWInteractor ()

@property (nonatomic, strong) NSMutableDictionary<NSString */* eventName */,PWInteractorModel *> *actionDict;
@property (nonatomic, strong) NSMutableArray *actions;

@end

@implementation PWInteractor

- (void)registerTarget:(id<PWAction>)target action:(SEL)select forEventName:(NSString *)eventName {

    PWInteractorModel *model = [[PWInteractorModel alloc] init];
    model.target = target;
    model.selector = select;
    
}

- (void)sendEventName:(NSString *)eventName withObjects:(id)object {
    // do something
    
}

- (NSMutableDictionary *)actionDict {
    if (!_actionDict) {
        _actionDict = [NSMutableDictionary dictionary];
    }
    return _actionDict;
}

@end
