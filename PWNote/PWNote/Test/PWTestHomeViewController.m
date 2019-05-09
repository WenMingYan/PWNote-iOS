//
//  PWTestHomeViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWTestHomeViewController.h"

@interface PWTestHomeViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PWTestHomeViewController

__PW_ROUTER_REGISTER__

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)initView {
    self.title = @"test";
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}
#pragma mark - --------------------UITableViewDelegate--------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [[self names] objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.names.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = [[self names] objectAtIndex:indexPath.row];
    [self routerURL:url withParam:nil];
}

#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

+ (NSString *)urlName {
    return @"test";
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (NSArray *)names {
    return @[
             @"pwnote://setting",
             @"pwnote://more",
             @"pwnote://home",
             @"pwnote://search",
             @"pwnote://tydialog",
             ];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
