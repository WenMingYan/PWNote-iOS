//
//  PWSettingViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWSettingViewController.h"
#import "PWTableViewDelegate.h"
#import "PWSettingDataSource.h"

@interface PWSettingViewController ()

@property (nonatomic, strong) PWTableViewDelegate *delegate;
@property (nonatomic, strong) PWSettingDataSource *dataSource;

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
    self.tableView.delegate = self.delegate;
    self.tableView.dataSource = self.delegate;
    [self.tableView reloadData];
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

- (PWSettingDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[PWSettingDataSource alloc] init];
        _dataSource.viewController = self;
    }
    return _dataSource;
}

- (PWTableViewDelegate *)delegate {
    if (!_delegate) {
        _delegate = [[PWTableViewDelegate alloc] initWithtableView:self.tableView];
        _delegate.dataSource = self.dataSource;
    }
    return _delegate;
}

@end
