//
//  UITableViewCell+PWItemView.m
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "UITableViewCell+PWItemView.h"
#import <objc/runtime.h>

@implementation UITableViewCell (PWItemView)

- (void)setItemView:(UIView<PWItemViewProtocol> *)itemView {
    objc_setAssociatedObject(self, @selector(itemView), itemView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIView <PWItemViewProtocol>*)itemView {
    return objc_getAssociatedObject(self, _cmd);
}

@end
