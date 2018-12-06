//
//  PWSettingDataSource.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWSettingDataSource.h"
#import "PWSettingViewModel.h"
#import "PWNetworkService.h"

@implementation PWSettingDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        PWSectionModel *sectionModel = [[PWSectionModel alloc] init];
        PWSettingViewModel *settingViewModel = [[PWSettingViewModel alloc] init];
        settingViewModel.title = @"检查更新";
        @weakify(self);
        settingViewModel.clickBlock = ^{
            @strongify(self);
            [self checkUpdate];
        };
        sectionModel.viewModels = @[settingViewModel];
        self.sectionModels = @[sectionModel];
    }
    return self;
}

- (void)checkUpdate {
    PWNetworkService *service = [[PWNetworkService alloc] init];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [MBProgressHUD showSuccess:@"已经是最新版本！"];
    //TODO: wmy
    [service postRequestWithMethod:@"checkupdate" withParam:param success:^(NSDictionary * _Nonnull param) {
    } fail:^(NSError * _Nonnull error) {
        
    }];
    
}

@end
