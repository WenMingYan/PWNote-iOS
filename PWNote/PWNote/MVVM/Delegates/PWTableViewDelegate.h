//
//  PWTableViewDelegate.h
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PWDataSource;

NS_ASSUME_NONNULL_BEGIN

@interface PWTableViewDelegate : NSObject <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) PWDataSource *dataSource;/**< 数据源  */



- (instancetype)initWithtableView:(UITableView *)tableView;

@property(nonatomic, weak) UIViewController *viewController;

@end

NS_ASSUME_NONNULL_END
