//
//  PWKeepViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/12/1.
//  Copyright © 2018 明妍. All rights reserved.
//  记事

#import "PWKeepViewController.h"
#import "PWKeepDataSource.h"
#import "PWTableViewAutoAlyoutDelegate.h"

@interface PWKeepViewController ()

@property (nonatomic, strong) PWKeepDataSource *dataSource;
@property (nonatomic, strong) PWTableViewAutoAlyoutDelegate *delegate;

@end

@implementation PWKeepViewController

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"记事";
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.delegate = self.delegate;
    self.tableView.dataSource = self.delegate;
    @weakify(self);
    [self.dataSource requestWithSuccess:^{
        @strongify(self);
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}
#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (PWKeepDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[PWKeepDataSource alloc] init];
    }
    return _dataSource;
}

- (PWTableViewAutoAlyoutDelegate *)delegate {
    if (!_delegate) {
        _delegate = [[PWTableViewAutoAlyoutDelegate alloc] initWithtableView:self.tableView];
        _delegate.dataSource = self.dataSource;
    }
    return _delegate;
}

@end
