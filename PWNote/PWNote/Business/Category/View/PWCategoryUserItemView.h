//
//  PWCategoryUserView.h
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWItemView.h"

typedef void(^ClickSearchBlock)(void);

@interface PWCategoryUserItemView : PWItemView

@property(nonatomic, copy) ClickSearchBlock searchBlock;


@end
