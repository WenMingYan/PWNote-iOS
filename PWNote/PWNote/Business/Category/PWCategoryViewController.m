//
//  PWCategoryViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/12/6.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWCategoryViewController.h"
#import "PWCategoryDataSource.h"
#import "PWTableViewDelegate.h"
#import "PWCategoryUserItemView.h"
#import "PWCategoryViewModel.h"
#import "PWHomeViewController.h"
#import "PWCategoryFooterItemView.h"
#import "PWCagegoryFooterViewModel.h"

@interface PWCategoryViewController ()

@property (nonatomic, strong) PWCategoryDataSource *dataSource;
@property (nonatomic, strong) PWCategoryUserItemView *userItemView; /**< 用户  */
@property (nonatomic, strong) PWCagegoryFooterViewModel *footerViewModel;

@end

@implementation PWCategoryViewController

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
    self.view.backgroundColor = [UIColor clearColor];
}
- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}
- (void)initData {
    self.tableViewDelegate.interactor = self.defaultInteractor;
    [self.defaultInteractor registerTarget:self action:@selector(onClickItem:) forEventName:kClickCategoryItem];
    @weakify(self);
    [self.dataSource requestWithSuccess:^{
        @strongify(self);
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}

- (void)initView {
    self.tableViewDelegate.dataSource = self.dataSource;
    [self.view addSubview:self.userItemView];
    CGFloat height = 60 + kSafeAreaStatusBarHeight;
    [self.userItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(height);
        make.width.equalTo(self.view);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.userItemView.mas_bottom);
    }];
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

#pragma mark - --------------------UICollectionViewDelegate, UICollectionViewDataSource--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

- (void)onClickItem:(PWCategoryViewModel *)viewModel {
    //TODO: wmy  关闭e页面，这里之后需要把category的进入动画改一下
//    [self dismiss];
    [self.homeViewController updateCategory:viewModel];
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (PWCategoryUserItemView *)userItemView {
    if (!_userItemView) {
        _userItemView = [[PWCategoryUserItemView alloc] init];
        _userItemView.viewModel = self.dataSource.userViewModel;
    }
    return _userItemView;
}

- (PWCategoryDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[PWCategoryDataSource alloc] init];
    }
    return _dataSource;
}

- (PWCagegoryFooterViewModel *)footerViewModel {
    if (!_footerViewModel) {
        _footerViewModel = [[PWCagegoryFooterViewModel alloc] init];
    }
    return _footerViewModel;
}

@end
