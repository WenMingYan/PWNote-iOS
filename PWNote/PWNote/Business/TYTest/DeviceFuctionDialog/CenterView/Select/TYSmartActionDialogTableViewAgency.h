//
//  TYDFTableView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectItemBlock)(NSInteger index);

@interface TYSmartActionDialogTableViewAgency : NSObject

@property (nonatomic, copy) NSArray<NSString *> *actions; /**< 选项  */
@property (nonatomic, strong) UITableView *selectTableView;
@property (nonatomic, assign) NSInteger selectIndex;
@property(nonatomic, copy) SelectItemBlock selectItemBlock;/**< 单选的选项回调  */

@end

NS_ASSUME_NONNULL_END
