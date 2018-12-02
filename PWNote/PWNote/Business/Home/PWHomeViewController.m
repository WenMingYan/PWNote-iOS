//
//  PWHomeViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWHomeViewController.h"
#import "PWMissionViewController.h"
#import "PWToDoListViewController.h"
#import "PWKeepViewController.h"
#import "PWSelectTitleView.h"
#import "PWUserView.h"

@interface PWHomeViewController () <PWSelectTitleViewDelegate, UIScrollViewDelegate>

//@property (nonatomic, strong) UIButton *moreBtn; /**< 更多  */
//@property (nonatomic, strong) UIButton *settingBtn; /**< 设置  */
#if DEBUG
@property (nonatomic, strong) UIButton *testBtn; /**< 测试button  */
#endif

@property (nonatomic, strong) PWSelectTitleView *smallScrollView; /**< 顶部小ScrollView  */
@property (nonatomic, strong) UIScrollView *bigScrollView; /**< scrollView  */

@property (nonatomic, strong) PWMissionViewController *mission;
@property (nonatomic, strong) PWToDoListViewController *todoList;
@property (nonatomic, strong) PWKeepViewController *keep;

@property (nonatomic, strong) PWUserView *userView;

@end

@implementation PWHomeViewController

__PW_ROUTER_REGISTER__

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    self.mission = [[PWMissionViewController alloc] init];
    self.todoList = [[PWToDoListViewController alloc] init];
    self.keep = [[PWKeepViewController alloc] init];
    [self.smallScrollView setTitles:@[@"任务",@"待办",@"记事"]];
    
}

- (void)initView {
    self.title = @"Home";
    [self.view addSubview:self.smallScrollView];
    [self.view addSubview:self.bigScrollView];
    UITapGestureRecognizer *userViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(onClickUser)];
    [self.userView addGestureRecognizer:userViewTap];
    
    [self.smallScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(35);
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    [self.bigScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.smallScrollView.mas_bottom);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
#if DEBUG
    UIBarButtonItem *testItem = [[UIBarButtonItem alloc] initWithCustomView:self.testBtn];
    self.navigationItem.rightBarButtonItems = @[testItem];
#endif
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------

- (void)selectTitleView:(PWSelectTitleView *)titleView didSelectIndex:(NSInteger)index {
    if (self.smallScrollView.selectedIndex == index) {
        switch (index) {
            case 0:
                [self.mission.tableView reloadData];
                break;
            case 1: {
                
            }
            case 2: {
                
            }
            default:
                break;
        }
    }
    [self.bigScrollView setContentOffset:CGPointMake(self.bigScrollView.frame.size.width * index, 0) animated:YES];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.smallScrollView setSelectedIndex:index];
}

#pragma mark - --------------------Event Response--------------


- (void)onClickUser {
    //TODO: wmy 到我的页面
    [self routerURL:@"pwnote://user" withParam:nil];
}

+ (NSString *)urlName {
    return @"home";
}

- (void)onClickTest {
    [self routerURL:@"pwnote://test" withParam:nil];
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (PWSelectTitleView *)smallScrollView {
    if (!_smallScrollView) {
        _smallScrollView = [[PWSelectTitleView alloc] init];
        _smallScrollView.delegate = self;
    }
    return _smallScrollView;
}

- (UIScrollView *)bigScrollView {
    if (!_bigScrollView) {
        _bigScrollView = [[UIScrollView alloc] init];
        [_bigScrollView addSubview:self.mission.view];
        [_bigScrollView addSubview:self.todoList.view];
        [_bigScrollView addSubview:self.keep.view];
        _bigScrollView.pagingEnabled = YES;
        _bigScrollView.delegate = self;
        [self.mission.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(self.bigScrollView);
            make.left.mas_equalTo(self.bigScrollView);
            make.top.mas_equalTo(self.bigScrollView);
            make.bottom.mas_equalTo(self.bigScrollView);
        }];
        [self.todoList.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(self.bigScrollView);
            make.left.mas_equalTo(self.mission.view.mas_right);
            make.top.mas_equalTo(self.bigScrollView);
            make.bottom.mas_equalTo(self.bigScrollView);
        }];
        [self.keep.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(self.bigScrollView);
            make.left.mas_equalTo(self.todoList.view.mas_right);
            make.top.mas_equalTo(self.bigScrollView);
            make.bottom.mas_equalTo(self.bigScrollView);
            make.right.mas_equalTo(self.bigScrollView);
        }];
    }
    return _bigScrollView;
}

- (PWUserView *)userView {
    if (!_userView) {
        _userView = [[PWUserView alloc] initWithSuperView:self.view];
    }
    return _userView;
}

#if DEBUG
- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_testBtn addTarget:self action:@selector(onClickTest) forControlEvents:UIControlEventTouchUpInside];
        [_testBtn setTitle:@"test" forState:UIControlStateNormal];
        [_testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _testBtn;
}
#endif

@end
