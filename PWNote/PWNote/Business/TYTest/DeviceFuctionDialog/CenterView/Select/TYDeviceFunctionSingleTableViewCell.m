//
//  TYDeviceFunctionSingleTableViewCell.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/6.
//  Copyright © 2019 明妍. All rights reserved.
// 

#import "TYDeviceFunctionSingleTableViewCell.h"
#import <Masonry/Masonry.h>
#import "TYDeviceFunctionDefine.h"

@interface TYDeviceFunctionSingleTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel; /**< 标题  */
@property (nonatomic, strong) UIImageView *selectImageView; /**< 是否选择的View  */

@end

@implementation TYDeviceFunctionSingleTableViewCell

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------
- (instancetype)init {
    if (self = [super init]) {
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

- (void)initView {

    [self addSubview:self.titleLabel];
    [self addSubview:self.selectImageView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TYScreenAdaptor(20));
        make.right.mas_lessThanOrEqualTo(self.selectImageView.mas_left).offset(-TYScreenAdaptor(15));
        make.centerY.equalTo(self);
    }];
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(TYScreenAdaptor(22));
        make.right.equalTo(self).offset(-TYScreenAdaptor(25));
    }];
}


#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (void)setModel:(id<TYDFSingleSectionModelProtocol>)model {
    _model = model;
    self.titleLabel.text = [model title];
    self.selectImageView.hidden = !model.isSelect;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = HEXCOLORA(0x22242C,1);
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UIImageView *)selectImageView {
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] init];
        _selectImageView.image = [UIImage imageNamed:@"ty_device_function_select"];
    }
    return _selectImageView;
}

@end
