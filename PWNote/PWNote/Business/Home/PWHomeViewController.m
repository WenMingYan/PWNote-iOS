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
#import "PWUserManager.h"
#import "PWCategoryViewController.h"

@interface PWHomeViewController () <PWSelectTitleViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *categoryBtn; /**< 分类  */
@property (nonatomic, strong) UIButton *settingBtn; /**< 设置  */
#if DEBUG
@property (nonatomic, strong) UIButton *testBtn; /**< 测试button  */
#endif

@property (nonatomic, strong) PWSelectTitleView *smallScrollView; /**< 顶部小ScrollView  */
@property (nonatomic, strong) UIScrollView *bigScrollView; /**< scrollView  */

@property (nonatomic, strong) PWMissionViewController *mission;
@property (nonatomic, strong) PWToDoListViewController *todoList;
@property (nonatomic, strong) PWKeepViewController *keep;

@property (nonatomic, strong) PWUserView *userView;
@property (nonatomic, strong) PWCategoryViewController *categoryVC;
@property (nonatomic, assign) BOOL isAnimated;/** < 是否在动画中*/
@property (nonatomic, strong) UIView *maskView; /**< 背景  */

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

- (void)setupSmallScrollView {
    [self.view addSubview:self.smallScrollView];
    [self.smallScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(35);
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

- (void)setupBigScrollView {
    [self.view addSubview:self.bigScrollView];
    [self.bigScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.smallScrollView.mas_bottom);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)setupCategoryVC {
    [self.view addSubview:self.maskView];
    self.maskView.hidden = YES;
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.categoryVC.view];
    self.categoryVC.view.hidden = YES;
    [self.categoryVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view).mas_offset(-50);
        make.right.mas_equalTo(self.view.mas_left);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)initView {
    self.title = @"Home";
    [self setupSmallScrollView];
    [self setupBigScrollView];
    [self setupCategoryVC];
    UITapGestureRecognizer *userViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(onClickUser)];
    [self.userView addGestureRecognizer:userViewTap];

    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView:self.settingBtn];
    
#if DEBUG
    UIBarButtonItem *testItem = [[UIBarButtonItem alloc] initWithCustomView:self.testBtn];
    self.navigationItem.rightBarButtonItems = @[testItem,settingItem];
#else
    self.navigationItem.rightBarButtonItems = @[settingItem];
#endif
    
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:self.categoryBtn];
    self.navigationItem.leftBarButtonItems = @[categoryItem];
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
    if ([[PWUserManager sharedInstance] isLogin]) {
        // 到我的页面
        [self routerURL:@"pwnote://user" withParam:nil];
    } else {
        @weakify(self);
        //TODO: wmy test
        [[PWUserManager sharedInstance] loginInWithUserName:@"mingyan" password:@"900523" withComplementation:^(BOOL success) {
            @strongify(self);
            [self routerURL:@"pwnote://user" withParam:nil];
        }];
    }
}

+ (NSString *)urlName {
    return @"home";
}

- (void)onClickTest {
    [self routerURL:@"pwnote://test" withParam:nil];
}

- (void)onClickSetting {
    [self routerURL:@"pwnote://setting" withParam:nil];
}

- (void)onClickCategory {
    //打开分类
    if (self.isAnimated) {
        return;
    }
    CGRect frame = self.categoryVC.view.frame;
    if (self.categoryVC.view.hidden) {
        //TODO: wmy 显示的动画
        frame.origin.x = 0;
        self.categoryVC.view.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.isAnimated = YES;
            self.categoryVC.view.frame = frame;
        } completion:^(BOOL finished) {
            self.isAnimated = NO;
            self.categoryVC.view.hidden = NO;
            self.maskView.hidden = NO;
        }];
    } else {
        //TODO: wmy 隐藏的动画
        frame.origin.x = - frame.size.width;
        [UIView animateWithDuration:0.5 animations:^{
            self.isAnimated = YES;
            self.categoryVC.view.frame = frame;
        } completion:^(BOOL finished) {
            self.isAnimated = NO;
            self.categoryVC.view.hidden = YES;
            self.maskView.hidden = YES;
        }];
    }
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UIButton *)settingBtn {
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingBtn.titleLabel.font = [AMIconfont fontWithSize:32];
        [_settingBtn setTitle:XIconShezhi forState:UIControlStateNormal];
        [_settingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(onClickSetting) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingBtn;
}

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

- (UIButton *)categoryBtn {
    if (!_categoryBtn) {
        _categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_categoryBtn addTarget:self action:@selector(onClickCategory) forControlEvents:UIControlEventTouchUpInside];
        _categoryBtn.titleLabel.font = [AMIconfont fontWithSize:32];
        [_categoryBtn setTitle:XIconCategory forState:UIControlStateNormal];
    }
    return _categoryBtn;
}

- (PWCategoryViewController *)categoryVC {
    if (!_categoryVC) {
        _categoryVC = [[PWCategoryViewController alloc] init];
    }
    return _categoryVC;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        UITapGestureRecognizer *maskTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(onClickCategory)];
        [_maskView addGestureRecognizer:maskTap];
    }
    return _maskView;
}

@end
