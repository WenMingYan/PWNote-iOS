//
//  PWMoreViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWMoreViewController.h"

@interface PWMoreViewController ()


@end

@implementation PWMoreViewController

__PW_ROUTER_REGISTER__

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    
}

- (void)initView {
    self.title = @"More";
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

+ (NSString *)urlName {
    return @"more";
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

@end
