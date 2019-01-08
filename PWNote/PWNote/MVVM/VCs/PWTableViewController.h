//
//  PWTableViewController.h
//  PWNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWViewController.h"
#import "PWTableViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWTableViewController : PWViewController

- (UITableView *)tableView;

- (PWTableViewDelegate *)tableViewDelegate;

@end

NS_ASSUME_NONNULL_END
