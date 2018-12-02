//
//  PWMissionViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/12/1.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWMissionViewController.h"
#import "PWTableViewDelegate.h"
#import "PWMissionDataSource.h"

@interface PWMissionViewController ()

@property (nonatomic, strong) PWMissionDataSource *dataSource;
@property (nonatomic, strong) PWTableViewDelegate *tableViewDelegate;

@end

@implementation PWMissionViewController

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务";
    self.tableView.delegate = self.tableViewDelegate;
    self.tableView.dataSource = self.tableViewDelegate;
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

- (PWMissionDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[PWMissionDataSource alloc] init];
    }
    return _dataSource;
}

- (PWTableViewDelegate *)tableViewDelegate {
    if (!_tableViewDelegate) {
        _tableViewDelegate = [[PWTableViewDelegate alloc] initWithtableView:self.tableView];
        _tableViewDelegate.dataSource = self.dataSource;
    }
    return _tableViewDelegate;
}

@end
