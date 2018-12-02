//
//  PWSelectTitleItem.m
//  PWNote
//
//  Created by 明妍 on 2018/12/1.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWSelectTitleItemCell.h"
#import <Masonry/Masonry.h>

@interface PWSelectTitleItemCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation PWSelectTitleItemCell

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

- (void)initView {

    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = self.titleLabel.font;
    [self.titleLabel.text sizeWithAttributes:dict];
    CGSize size = [self.titleLabel.text sizeWithAttributes:dict];
    attributes.frame = CGRectMake(0, 0, size.width, size.height);
    //计算cellSize，当前要求高度固定40，宽度自适应，现在根据字符串求出所需宽度+42，contentLabel相对cell左右各有20的空间
    //根据具体需求作灵活处理
    return attributes;
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (isSelected) {
        self.titleLabel.textColor = [UIColor redColor];
    } else {
        self.titleLabel.textColor = [UIColor blackColor];
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

@end
