//
//  PWHomeViewController.m
//  PWNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWHomeViewController.h"


@interface PWHomeViewController ()

//@property (nonatomic, strong) UIButton *moreBtn; /**< 更多  */
//@property (nonatomic, strong) UIButton *settingBtn; /**< 设置  */
#if DEBUG
@property (nonatomic, strong) UIButton *testBtn; /**< 测试button  */
#endif

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
    
}

- (void)initView {
    self.title = @"Home";
#if DEBUG
    UIBarButtonItem *testItem = [[UIBarButtonItem alloc] initWithCustomView:self.testBtn];
    self.navigationItem.rightBarButtonItems = @[testItem];
#endif
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

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

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
