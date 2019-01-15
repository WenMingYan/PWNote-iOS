//
//  PWSearchViewController.m
//  PWNote
//
//  Created by mingyan on 2019/1/9.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWSearchViewController.h"


@interface PWSearchViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UIView *navigationView; /**< 顶部视图  */
@property (nonatomic, strong) UISearchBar *searchBar; /**< 搜索框  */
@property(nonatomic, weak) UITextField *searhTextField;

@end

@implementation PWSearchViewController

__PW_ROUTER_REGISTER_PRESENT__

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kSafeAreaNavBarHeight);
        make.top.left.width.equalTo(self.view);
    }];
    [self.searchBar becomeFirstResponder];
    for (UIView *view in _searchBar.subviews[0].subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
    }
    
    self.searhTextField = [self.searchBar valueForKey:@"_searchField"];
    [self.searhTextField setLeftViewMode:UITextFieldViewModeNever];
    
    self.searhTextField.layer.shadowColor = [UIColor blackColor].CGColor;
    self.searhTextField.layer.shadowOpacity = 0.2f;
    self.searhTextField.layer.shadowRadius = 4.f;
    self.searhTextField.layer.shadowOffset = CGSizeMake(0, 0);
    
    self.navigationView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationView.layer.shadowOpacity = 0.2f;
    self.navigationView.layer.shadowRadius = 4.f;
    self.navigationView.layer.shadowOffset = CGSizeMake(0, -2);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

+ (NSString *)urlName {
    return @"search";
}

#pragma mark UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText = %@",searchText);
}

- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc] init];
        _navigationView.backgroundColor = kWhiteColor;
        [_navigationView addSubview:self.searchBar];
        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.navigationView).offset(-3);
            make.left.mas_equalTo(16);
            make.right.mas_equalTo(-16);
            make.height.mas_equalTo(44);
        }];
    }
    return _navigationView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.showsCancelButton = YES;
        _searchBar.delegate = self;
        _searchBar.showsScopeBar = NO;
        _searchBar.tintColor = kThemeColor;
        [_searchBar setSearchTextPositionAdjustment:UIOffsetMake(10, 0)];
    }
    return _searchBar;
}

@end
