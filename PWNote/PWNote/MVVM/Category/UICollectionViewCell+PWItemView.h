//
//  UICollectionViewCell+PWItemView.h
//  PWNote
//
//  Created by 明妍 on 2018/12/6.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWItemViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewCell (PWItemView)

@property (nonatomic, strong) UIView<PWItemViewProtocol> *itemView;

@end

NS_ASSUME_NONNULL_END
