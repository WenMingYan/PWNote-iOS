//
//  PWViewModelProtocol.h
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#ifndef PWViewModelProtocol_h
#define PWViewModelProtocol_h

#import <UIKit/UIKit.h>

@protocol PWItemViewProtocol;

@protocol PWViewModelProtocol <NSObject>

@property (nonatomic, weak) UIView<PWItemViewProtocol> *itemView;
@property (nonatomic, strong) NSObject *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (CGSize)itemSize;

- (Class)itemViewClass;

@end

#endif /* PWViewModelProtocol_h */
