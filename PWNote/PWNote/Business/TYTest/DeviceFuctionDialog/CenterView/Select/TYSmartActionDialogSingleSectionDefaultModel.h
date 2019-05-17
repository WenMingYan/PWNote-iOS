//
//  TYDeviceSingleSectionFunctionDefaultModel.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYSmartActionDialogModelProtocol.h"

@interface TYSmartActionDialogSingleSectionDefaultModel : NSObject <TYSmartActionDialogSelectorModelProtocol>

@property (nonatomic, strong) NSString *dialogIconName;
@property (nonatomic, strong) NSString *dialogTitle;
@property (nonatomic, assign) NSInteger originalSelectIndex;
@property (nonatomic, strong) NSArray <NSString *> *dialogOptions;

@end
