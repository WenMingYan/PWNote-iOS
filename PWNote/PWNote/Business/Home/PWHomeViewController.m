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
#import "PWUserView.h"
#import "PWUserManager.h"
#import "PWCategoryViewController.h"
#import "PWUpdateUtils.h"
#import "PWRouter.h"
#import "PWMissionDataSource.h"
#import "PWTableViewDelegate.h"

@interface PWHomeViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *categoryBtn; /**< 分类  */
@property (nonatomic, strong) UIButton *settingBtn; /**< 设置  */
#if DEBUG
@property (nonatomic, strong) UIButton *testBtn; /**< 测试button  */
#endif

@property (nonatomic, strong) PWCategoryViewController *categoryVC;
@property (nonatomic, assign) BOOL isAnimated;/** < 是否在动画中*/
@property (nonatomic, strong) UIView *maskView; /**< 背景  */

@property (nonatomic, strong) PWMissionDataSource *dataSource;

@end

@implementation PWHomeViewController

__PW_ROUTER_REGISTER__

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
    @weakify(self);
    // TODO: wmy test
    [PWUpdateUtils checkUpdateWithSuccess:^(BOOL canUpdate, NSString *updateAdd) {
        @strongify(self);
        if (canUpdate) {
            [self showUpdateAlert:updateAdd];
        }
    } fail:^(NSError *err) {
        NSLog(@"");
    }];
}


- (void)showUpdateAlert:(NSString *)updateAdd {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"有版本！"
                                                                        message:@"有新版本，是否需要升级"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[PWRouter sharedInstance] routerURL:updateAdd param:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)initData {
    
    self.tableViewDelegate.dataSource = self.dataSource;
    self.tableViewDelegate.viewController = self;
    @weakify(self);
    [self.dataSource requestWithSuccess:^{
        @strongify(self);
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
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
    [self setupCategoryVC];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------

#pragma mark - --------------------Event Response--------------

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
        self.maskView.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.isAnimated = YES;
            self.maskView.hidden = NO;
            self.categoryVC.view.frame = frame;
        } completion:^(BOOL finished) {
            self.isAnimated = NO;
            self.categoryVC.view.hidden = NO;
        }];
    } else {
        //TODO: wmy 隐藏的动画
        self.maskView.hidden = YES;
        frame.origin.x = - frame.size.width;
        [UIView animateWithDuration:0.3 animations:^{
            self.isAnimated = YES;
            self.categoryVC.view.frame = frame;
            self.maskView.hidden = YES;
        } completion:^(BOOL finished) {
            self.isAnimated = NO;
            self.categoryVC.view.hidden = YES;
        }];
    }
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UIButton *)settingBtn {
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingBtn.titleLabel.font = [AMIconfont fontWithSize:24];
        [_settingBtn setTitle:XIconShezhi forState:UIControlStateNormal];
        [_settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(onClickSetting) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingBtn;
}

#if DEBUG
- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_testBtn addTarget:self action:@selector(onClickTest) forControlEvents:UIControlEventTouchUpInside];
        [_testBtn setTitle:@"test" forState:UIControlStateNormal];
        [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _testBtn;
}
#endif

- (UIButton *)categoryBtn {
    if (!_categoryBtn) {
        _categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_categoryBtn addTarget:self action:@selector(onClickCategory) forControlEvents:UIControlEventTouchUpInside];
        _categoryBtn.titleLabel.font = [AMIconfont fontWithSize:24];
        [_categoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
        _maskView.alpha = 0.6;
        UITapGestureRecognizer *maskTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(onClickCategory)];
        [_maskView addGestureRecognizer:maskTap];
    }
    return _maskView;
}

- (PWMissionDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[PWMissionDataSource alloc] init];
    }
    return _dataSource;
}


@end
