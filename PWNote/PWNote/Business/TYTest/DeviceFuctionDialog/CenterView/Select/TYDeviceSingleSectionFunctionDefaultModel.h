//
//  TYDeviceSingleSectionFunctionDefaultModel.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYDeviceFuctionModelProtocol.h"

@interface TYDeviceSingleSectionFunctionDefaultModel : NSObject <TYDFSingleSectionModelProtocol>

@property (nonatomic, assign, getter=isSelect) BOOL select;

@end
