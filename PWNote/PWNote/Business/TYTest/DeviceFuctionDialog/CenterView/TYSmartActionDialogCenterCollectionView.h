//
//  TYDFCenterCollectionView.h
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSmartActionDialogModelProtocol.h"
#import "TYSmartActionDialogEventDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSmartActionDialogCenterCollectionView : UIView

@property (nonatomic, weak) NSArray<id<TYSmartActionDialogModelProtocol>> *models;
@property(nonatomic, weak) id<TYDFCompleteDialogEventDelegate> delegate;

- (void)selectIndex:(NSInteger)index;

@end


NS_ASSUME_NONNULL_END
