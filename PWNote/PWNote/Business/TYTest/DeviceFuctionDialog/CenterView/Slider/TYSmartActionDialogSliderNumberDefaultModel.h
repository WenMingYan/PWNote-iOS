//
//  TYDeviceSliderFuctionDefaultModel.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYSmartActionDialogModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogSliderNumberDefaultModel : NSObject <TYSmartActionDialogNumberModelProtocol>

@property (nonatomic, strong) NSString *dialogTitle;
@property (nonatomic, strong) NSString *dialogIconName;
@property (nonatomic, assign) double dialogMax;
@property (nonatomic, assign) double dialogMin;
@property (nonatomic, assign) double dialogStep;
@property (nonatomic, assign) double dialogStartValue;
@property (nonatomic, assign) TYSmartActionDialogNumberModelType modelType;

@end

NS_ASSUME_NONNULL_END
