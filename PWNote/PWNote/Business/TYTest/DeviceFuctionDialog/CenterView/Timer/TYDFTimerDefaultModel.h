//
//  TYDFTimerDefaultModel.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYDeviceFuctionModelProtocol.h"

@interface TYDFTimerDefaultModel : NSObject <TYDFTimerModelProtocol>

@property (nonatomic, assign) BOOL hasSet;/** < 是否设定过倒计时*/
@property (nonatomic, assign) TYDFTimerSetType timerSetType;

@end
