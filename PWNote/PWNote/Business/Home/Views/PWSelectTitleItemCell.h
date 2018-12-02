//
//  PWSelectTitleItem.h
//  PWNote
//
//  Created by 明妍 on 2018/12/1.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWSelectTitleItemCell : UICollectionViewCell

@property (nonatomic, assign) BOOL isSelected;

- (void)setTitle:(NSString *)title;

@end
