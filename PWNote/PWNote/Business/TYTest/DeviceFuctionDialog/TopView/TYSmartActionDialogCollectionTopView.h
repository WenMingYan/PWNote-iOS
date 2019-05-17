//
//  TYDFCollectionTopView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickBlock)(NSInteger index,id<TYSmartActionDialogModelProtocol> model);

@interface TYSmartActionDialogCollectionTopView : UIView

@property (nonatomic, strong) NSArray<id<TYSmartActionDialogModelProtocol>> *models;

@property(nonatomic, copy) ClickBlock clickBlock;

@end

NS_ASSUME_NONNULL_END
