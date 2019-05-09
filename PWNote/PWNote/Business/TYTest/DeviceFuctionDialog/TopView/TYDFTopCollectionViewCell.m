//
//  TYDFTopCollectionViewCell.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYDFTopCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "TYHomeDeviceControlItemView.h"

@interface TYDFTopCollectionViewCell ()

@property (nonatomic, strong) TYHomeDeviceControlItemView *itemView;

@end

@implementation TYDFTopCollectionViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.itemView];
        [self.itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)setItemData:(id<TYSHDeviceQuickControlItemData>)itemData {
    self.itemView.itemData = itemData;
}

- (TYHomeDeviceControlItemView *)itemView {
    if (!_itemView) {
        _itemView = [[TYHomeDeviceControlItemView alloc] init];
    }
    return _itemView;
}

@end
