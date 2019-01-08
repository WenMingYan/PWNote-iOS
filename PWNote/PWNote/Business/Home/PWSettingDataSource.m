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
#import "PWUpdateUtils.h"
#import "PWRouter.h"

@interface PWSettingDataSource ()

@property (nonatomic, strong) PWSettingViewModel *checkUpdateViewModel; /**< 检查更新  */
@property (nonatomic, strong) PWSettingViewModel *showAllMissionViewModel; /**< 显示所有任务  */

@end

@implementation PWSettingDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        PWSectionModel *sectionModel = [[PWSectionModel alloc] init];
        sectionModel.viewModels = @[self.checkUpdateViewModel];
        self.sectionModels = @[sectionModel];
    }
    return self;
}

- (void)checkUpdate {
    [PWUpdateUtils checkUpdateWithSuccess:^(BOOL canUpdate, NSString *updateAdd) {
        if (canUpdate) {
            [self showUpdateAlert:updateAdd];
        } else {
            [MBProgressHUD showSuccess:@"已经是最新版本！"];
        }
    } fail:^(NSError *err) {
        
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
    
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}


- (PWSettingViewModel *)checkUpdateViewModel {
    if (!_checkUpdateViewModel) {
        _checkUpdateViewModel = [[PWSettingViewModel alloc] init];
        _checkUpdateViewModel.title = @"检查更新";
        @weakify(self);
        _checkUpdateViewModel.clickBlock = ^{
            @strongify(self);
            [self checkUpdate];
        };
    }
    return _checkUpdateViewModel;
}


@end
