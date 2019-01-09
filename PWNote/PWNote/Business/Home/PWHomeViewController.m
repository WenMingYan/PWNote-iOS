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
#import "PWBigTitleViewModel.h"
#import "PWCategoryViewModel.h"
#import "PWHomeCategoryTransition.h"
#import "PWCagegoryFooterViewModel.h"
#import "PWCategoryFooterItemView.h"

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

@property (nonatomic, strong) PWHomeCategoryTransition *transition; /**< 首页-分类页转场动画  */

@property (nonatomic, strong) PWCategoryFooterItemView *footerItemView;
@property (nonatomic, strong) PWCagegoryFooterViewModel *footerViewModel;

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
        self.title = [self.dataSource.titleModel bigTitle];
    } fail:^(NSError *error) {
        
    }];
}

- (void)setupCategoryVC {
    [self.view addSubview:self.maskView];
    self.maskView.hidden = YES;
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
    
    [self.view addSubview:self.footerItemView];
    CGFloat height = [self.footerItemView.viewModel itemSize].height;
    [self.footerItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(height);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kSafeAreaNavBarHeight);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.footerItemView.mas_top);
    }];
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
    [self presentViewController:self.categoryVC animated:YES completion:nil];
}



- (void)updateCategory:(PWCategoryViewModel *)viewModel {
    [self onClickCategory];
    self.title = viewModel.title;
//    [self.dataSource requestWithSuccess:^{
//        [self.tableView reloadData];
//    } fail:^(NSError *error) {
//
//    }];
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UIButton *)settingBtn {
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingBtn.titleLabel.font = [AMIconfont fontWithSize:24];
        [_settingBtn setTitle:XIconShezhi forState:UIControlStateNormal];
        [_settingBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
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
        [_testBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    }
    return _testBtn;
}
#endif

- (UIButton *)categoryBtn {
    if (!_categoryBtn) {
        _categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_categoryBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        [_categoryBtn addTarget:self action:@selector(onClickCategory) forControlEvents:UIControlEventTouchUpInside];
        _categoryBtn.titleLabel.font = [AMIconfont fontWithSize:24];
        [_categoryBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_categoryBtn setTitle:XIconCategory forState:UIControlStateNormal];
    }
    return _categoryBtn;
}

- (PWCategoryViewController *)categoryVC {
    if (!_categoryVC) {
        _categoryVC = [[PWCategoryViewController alloc] init];
        _categoryVC.homeViewController = self;
        _categoryVC.transitioningDelegate = self.transition;
    }
    return _categoryVC;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = kLightSubTitleColor;
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

- (PWHomeCategoryTransition *)transition {
    if (!_transition) {
        _transition = [[PWHomeCategoryTransition alloc] init];
    }
    return _transition;
}

- (PWCategoryFooterItemView *)footerItemView {
    if (!_footerItemView) {
        _footerItemView = [[PWCategoryFooterItemView alloc] init];
        PWCagegoryFooterViewModel *footerViewModel = [[PWCagegoryFooterViewModel alloc] init];
        footerViewModel.title = @"添加任务";
        _footerItemView.viewModel = footerViewModel;
        self.footerViewModel = footerViewModel;
        _footerItemView.layer.shadowColor = [UIColor blackColor].CGColor;
        _footerItemView.layer.shadowOpacity = 0.2f;
        _footerItemView.layer.shadowRadius = 4.f;
        _footerItemView.layer.shadowOffset = CGSizeMake(0, -4);
    }
    return _footerItemView;
}

@end
