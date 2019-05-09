//
//  TYHomeDeviceControlItemView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYHomeDeviceControlItemView.h"
#import "UIColor+TYHex.h"
#import "UIView+TYFrame.h"

@implementation TYHomeDeviceControlItemView

- (instancetype)init {
    if (self = [super init]) {
        self.accessibilityIdentifier = @"homepage_fold_switch";
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor clearColor];
    
    _iconLabel = [UILabel new];
    _iconLabel.font = [UIFont fontWithName:@"iconfont" size:22];
    _iconLabel.numberOfLines = 1;
    [self addSubview:_iconLabel];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor ty_colorWithHex:0x4b4b4b];
    _nameLabel.numberOfLines = 1;
    [self addSubview:_nameLabel];
    
    _valueLabel = [UILabel new];
    _valueLabel.font = [UIFont systemFontOfSize:10];
    _valueLabel.textColor = [UIColor ty_colorWithHex:0x8a8e91];
    _valueLabel.numberOfLines = 1;
    [self addSubview:_valueLabel];
}


- (void)setItemData:(id<TYSHDeviceQuickControlItemData>)itemData {
    _itemData = itemData;
    _iconLabel.textColor = [UIColor ty_colorWithStringHex:itemData.iconColor];
    [self refreshWithIcon:itemData.imageName name:itemData.title value:itemData.subTitle];
}

- (void)refreshWithIcon:(NSString *)iconName name:(NSString *)name value:(NSString *)value {
    _iconLabel.text = iconName;
    _iconLabel.ty_width = self.ty_width - 6;
    [_iconLabel sizeToFit];
    _iconLabel.ty_centerX = self.ty_width/2.0;
    
    _nameLabel.text = name;
    [_nameLabel sizeToFit];
    _nameLabel.ty_width = self.ty_width - 6;
    _nameLabel.ty_centerX = self.ty_width/2.0;
    
    _valueLabel.text = value;
    _valueLabel.ty_width = self.ty_width - 6;
    [_valueLabel sizeToFit];
    _valueLabel.ty_centerX = self.ty_width/2.0;
    
    CGFloat h = _iconLabel.ty_height + 5 + _nameLabel.ty_height + 3 + _valueLabel.ty_height;
    _iconLabel.ty_top = (self.ty_height - h)/2.0;
    _nameLabel.ty_top = _iconLabel.ty_bottom + 5;
    _valueLabel.ty_top = _nameLabel.ty_bottom + 3;
}


@end
