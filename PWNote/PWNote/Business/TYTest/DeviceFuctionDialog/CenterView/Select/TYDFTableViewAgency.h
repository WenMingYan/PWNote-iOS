//
//  TYDFTableView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYDeviceFuctionModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectItemBlock)(id<TYDFSingleSectionModelProtocol> model,NSInteger index);

@interface TYDFTableViewAgency : NSObject

@property (nonatomic, strong) id<TYDFSingleSectionModelProtocol> model;
@property (nonatomic, strong) NSArray <TYDFSingleSectionModelProtocol> *actions; /**< 选项  */

@property (nonatomic, strong) UITableView *selectTableView;

@property(nonatomic, copy) SelectItemBlock selectItemBlock;/**< 单选的选项回调  */

@end

NS_ASSUME_NONNULL_END
