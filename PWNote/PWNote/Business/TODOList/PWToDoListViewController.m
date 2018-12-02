//
//  PWToDoListViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/12/1.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWToDoListViewController.h"

@interface PWToDoListViewController ()

@end

@implementation PWToDoListViewController

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)initData {
    self.title = @"待办";
}

- (void)initView {
    
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

@end
