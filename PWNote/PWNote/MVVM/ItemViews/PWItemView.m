//
//  PWItemView.m
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWItemView.h"

@implementation PWItemView

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

- (void)setViewModel:(id<PWViewModelProtocol>)viewModel {
    _viewModel = viewModel;
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------


- (void)onSelected {
    
}

@end
