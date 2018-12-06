//
//  PWTableViewAutoAlyoutDelegate.h
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PWDataSource;

@interface PWTableViewAutoAlyoutDelegate : NSObject <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) PWDataSource *dataSource;/**< 数据源  */

- (instancetype)initWithtableView:(UITableView *)tableView;
@end

