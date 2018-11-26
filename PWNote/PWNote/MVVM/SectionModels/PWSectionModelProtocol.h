//
//  PWSectionModelProtocol.h
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#ifndef PWSectionModelProtocol_h
#define PWSectionModelProtocol_h

@protocol PWViewModelProtocol;

@protocol PWSectionModelProtocol <NSObject>

@property (nonatomic, strong) NSArray<id<PWViewModelProtocol>> *viewModels;

@end

#endif /* PWSectionModelProtocol_h */
