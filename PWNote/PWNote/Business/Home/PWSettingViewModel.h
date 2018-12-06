//
//  PWSettingViewModel.h
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWViewModel.h"

typedef void(^OnClickBlock)(void);

@interface PWSettingViewModel : PWViewModel

@property(nonatomic, copy) OnClickBlock clickBlock;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;



@end
