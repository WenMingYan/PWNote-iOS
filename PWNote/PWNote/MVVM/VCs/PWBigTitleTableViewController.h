//
//  PWBigTitleTableViewController.h
//  PWNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWViewController.h"

@class PWTableViewDelegate;

@interface PWBigTitleTableViewController : PWViewController

- (UITableView *)tableView;
- (PWTableViewDelegate *)tableViewDelegate;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;


@end
