//
//  PWMoreViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWMoreViewController.h"
#import "PWTableViewDelegate.h"

@interface PWMoreViewController ()

@property (nonatomic, strong) PWTableViewDelegate *tableDelegate;

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
    self.tableView.delegate = self.tableDelegate;
    self.tableView.dataSource = self.tableDelegate;
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

- (PWTableViewDelegate *)tableDelegate {
    if (!_tableDelegate) {
        _tableDelegate = [[PWTableViewDelegate alloc] init];
    }
    return _tableDelegate;
}


@end
