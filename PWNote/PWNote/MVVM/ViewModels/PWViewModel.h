//
//  PWViewModel.h
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWViewModel : NSObject <PWViewModelProtocol>

@property (nonatomic, weak) UIView<PWItemViewProtocol> *itemView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSObject *model;



@end

NS_ASSUME_NONNULL_END
