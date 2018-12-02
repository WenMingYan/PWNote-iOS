//
//  PWMissionViewModel.h
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWViewModel.h"

@interface PWMissionViewModel : PWViewModel

@property (nonatomic, assign) BOOL isSelected;/** < 是否选中*/

- (NSString *)title;

@end
