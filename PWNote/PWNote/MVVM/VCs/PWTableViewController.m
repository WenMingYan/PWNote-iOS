//
//  PWTableViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWTableViewController.h"

@interface PWTableViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PWTableViewController

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
#if DEBUG
        _tableView.layer.borderWidth = 1;
        _tableView.layer.borderColor = [UIColor redColor].CGColor;
#endif
    }
    return _tableView;
}

@end
