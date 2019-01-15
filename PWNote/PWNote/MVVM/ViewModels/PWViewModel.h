//
//  PWViewModel.h
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+PWUtils.h"
#import "PWViewModel.h"
#import "PWUtils.h"
#import "PWViewModelProtocol.h"
#import "PWSkinManager.h"
#import "PWItemView.h"

NS_ASSUME_NONNULL_BEGIN

@class PWItemView;

@interface PWViewModel : NSObject <PWViewModelProtocol>

@property (nonatomic, weak) PWItemView<PWItemViewProtocol> *itemView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSObject *model;


@end

NS_ASSUME_NONNULL_END
