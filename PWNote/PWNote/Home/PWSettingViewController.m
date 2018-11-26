//
//  PWSettingViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWSettingViewController.h"

@interface PWSettingViewController ()

@end

@implementation PWSettingViewController

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
    self.title = @"Setting";
}
#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

+ (NSString *)urlName {
    return @"setting";
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------
@end
