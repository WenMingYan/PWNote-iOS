//
//  PWItemView.h
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWItemViewProtocol.h"
#import "PWViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWItemView : UIView <PWItemViewProtocol>

@property(nonatomic, weak) id<PWViewModelProtocol> viewModel;/**< 数据源  */

@end

NS_ASSUME_NONNULL_END
