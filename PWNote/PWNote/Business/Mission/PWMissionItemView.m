//
//  PWMissionItemView.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWMissionItemView.h"
#import "PWMissionViewModel.h"

@interface PWMissionItemView ()

@property (nonatomic, strong) UILabel *selectLabel; /**< 是否选中  */
@property (nonatomic, strong) UILabel *titleLabel; /**< 标题  */

@end

@implementation PWMissionItemView


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
    [self addSubview:self.selectLabel];
    [self addSubview:self.titleLabel];
    
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(24);
        make.left.mas_equalTo(kMargin);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.selectLabel.mas_right).offset(kMargin);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)setViewModel:(id<PWViewModelProtocol>)model {
    [super setViewModel:model];
    if ([model isKindOfClass:[PWMissionViewModel class]]) {
        PWMissionViewModel *viewModel = (PWMissionViewModel *)model;
        self.titleLabel.text = [viewModel title];
        NSString *oldPrice = self.titleLabel.text;
        if (viewModel.isSelected) {
            self.selectLabel.text = XIconSquarecheckfill;
            self.selectLabel.textColor = [UIColor grayColor];
            NSUInteger length = [oldPrice length];
            self.titleLabel.textColor = [UIColor grayColor];
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
            [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
            [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, length)];
            [self.titleLabel setAttributedText:attri];
            
        } else {
            self.selectLabel.text = XIconSquare;
            self.titleLabel.textColor = [UIColor blackColor];
            self.selectLabel.textColor = [UIColor blackColor];
            NSUInteger length = [oldPrice length];
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
            [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, length)];
            [self.titleLabel setAttributedText:attri];
        }
        
    }
}
#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

- (void)refreshView {
    self.viewModel = self.viewModel;
}

- (void)onSelected {
    PWMissionViewModel *viewModel = (PWMissionViewModel *)self.viewModel;
    viewModel.isSelected = !viewModel.isSelected;
    [self refreshView];
    //TODO: wmy 任务已完成请求
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UILabel *)selectLabel {
    if (!_selectLabel) {
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.font  = [AMIconfont fontWithSize:24];
    }
    return _selectLabel;
}


@end
