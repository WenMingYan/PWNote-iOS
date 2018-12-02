//
//  PWSelectTitleView.h
//  PWNote
//
//  Created by 明妍 on 2018/12/1.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PWSelectTitleView;

@protocol PWSelectTitleViewDelegate <NSObject>

- (void)selectTitleView:(PWSelectTitleView *)titleView didSelectIndex:(NSInteger)index;

@end

@interface PWSelectTitleView : UIView

@property(nonatomic, weak) id<PWSelectTitleViewDelegate> delegate;
@property (nonatomic, assign) NSInteger selectedIndex;

- (void)setTitles:(NSArray *)titles;

@end

