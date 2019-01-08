//
//  PWItemView.h
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "UIImageView+PWWebCatch.h"
#import "AMIconfont.h"
#import "PWUtils.h"
#import "PWItemViewProtocol.h"
#import "PWViewModelProtocol.h"
#import "PWSkinManager.h"
#import "PWInteractor.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWItemView : UIView <PWItemViewProtocol>

@property(nonatomic, weak) id<PWViewModelProtocol> viewModel;/**< 数据源  */
@property(nonatomic, weak) PWInteractor *interactor;

@end

NS_ASSUME_NONNULL_END
