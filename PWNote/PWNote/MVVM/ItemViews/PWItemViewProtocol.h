//
//  PWItemViewProtocol.h
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#ifndef PWItemViewProtocol_h
#define PWItemViewProtocol_h

@protocol PWViewModelProtocol;

@protocol PWItemViewProtocol <NSObject>

@property(nonatomic, weak) id<PWViewModelProtocol> viewModel;/**< 数据源  */

- (void)onSelected;

@end

#endif /* PWItemViewProtocol_h */
