//
//  TYDFTimerDefaultModel.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYSmartActionDialogModelProtocol.h"

@interface TYSmartActionDialogTimerDefaultModel : NSObject <TYSmartActionDialogTimerModelProtocol>

@property (nonatomic, strong) NSString *dialogTitle;
@property (nonatomic, strong) NSString *dialogIconName;
@property (nonatomic, assign) NSTimeInterval dialogTimer;
@property (nonatomic, assign) BOOL hasSetTimer;/** < 是否设定过倒计时*/
@property (nonatomic, assign) TYSmartActionDialogTimerSetType timerSetType;

@end
