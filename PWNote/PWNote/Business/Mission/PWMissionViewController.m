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
    
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

@end
