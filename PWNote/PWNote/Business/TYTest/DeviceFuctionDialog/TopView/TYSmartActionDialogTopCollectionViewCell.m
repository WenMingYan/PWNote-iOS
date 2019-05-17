//
//  TYDFTopCollectionViewCell.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogTopCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"

@interface TYSmartActionDialogTopCollectionViewCell ()

@property(nonatomic, weak) id<TYSmartActionDialogModelProtocol> itemData;

@property (nonatomic, strong) UILabel *iconLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *selectView;

@end

@implementation TYSmartActionDialogTopCollectionViewCell

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)initView {
    self.accessibilityIdentifier = @"homepage_fold_switch";
    [self addSubview:self.iconLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.selectView];
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(TYScreenAdaptor(19));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(self.iconLabel.mas_bottom).offset(TYScreenAdaptor(6));
        make.width.mas_lessThanOrEqualTo(self.mas_width);
    }];
    self.selectView.layer.cornerRadius = TYScreenAdaptor(3);
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(TYScreenAdaptor(10));
        make.height.mas_equalTo(TYScreenAdaptor(3));
        make.centerX.equalTo(self);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(TYScreenAdaptor(4));
    }];
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (void)setSelectCell:(BOOL)selectCell {
    _selectCell = selectCell;
    self.selectView.hidden = !selectCell;
    if (selectCell) {
        self.iconLabel.textColor = HEXCOLOR(0x495054);
        self.titleLabel.textColor = HEXCOLOR(0x495054);
        _titleLabel.font = [UIFont systemFontOfSize:TYScreenAdaptor(12) weight:UIFontWeightSemibold];
    } else {
        self.iconLabel.textColor = HEXCOLOR(0xA2A3AA);
        self.titleLabel.textColor = HEXCOLOR(0xA2A3AA);
        _titleLabel.font = [UIFont systemFontOfSize:TYScreenAdaptor(12) weight:UIFontWeightRegular];
    }
}

- (void)setItemData:(id<TYSmartActionDialogModelProtocol>)itemData {
    _itemData = itemData;
    if ([itemData respondsToSelector:@selector(dialogIconNamedialogIconNamedialogIconNamedialogIconNamedialogIconNamedialogIconNamedialogIconName)]) {
        self.iconLabel.text = [itemData dialogIconName];
    }
    if ([itemData respondsToSelector:@selector(smartActionDialogTitlesmartActionDialogTitlesmartActionDialogTitlesmartActionDialogTitlesmartActionDialogTitlesmartActionDialogTitlesmartActionDialogTitle)]) {
        self.titleLabel.text = [itemData dialogTitle];
    }
}


- (UIView *)selectView {
    if (!_selectView) {
        _selectView = [[UIView alloc] init];
        _selectView.backgroundColor = HEXCOLOR(0xFF4800);
    }
    return _selectView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = HEXCOLOR(0xA2A3AA);
        _titleLabel.font = [UIFont systemFontOfSize:TYScreenAdaptor(12) weight:UIFontWeightSemibold];
    }
    return _titleLabel;
}

- (UILabel *)iconLabel {
    if (!_iconLabel) {
        _iconLabel = [[UILabel alloc] init];
        _iconLabel.textColor = HEXCOLOR(0xA2A3AA);
        _iconLabel.font = [UIFont fontWithName:@"iconfont" size:TYScreenAdaptor(20)];
    }
    return _iconLabel;
}
@end
