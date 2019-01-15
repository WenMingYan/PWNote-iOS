//
//  PWBigTitleView.m
//  PWNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "PWBigTitleView.h"
#import <Masonry/Masonry.h>
#import "PWBigTitleViewModel.h"

@interface PWBigTitleView () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *bigTitleLabel;
@property (nonatomic, strong) UITextField *textField; /**< 标题  */
@property (nonatomic, strong) UILabel *subTitleLabel; /**< 小标题  */

@end

@implementation PWBigTitleView

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

- (PWItemViewSelectStyle)itemviewStyle {
    return PWItemViewStyleNone;
}

- (void)initView {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bigTitleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.textField];
    [self.bigTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(-10);
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bigTitleLabel);
        make.bottom.equalTo(self.bigTitleLabel.mas_top);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigTitleLabel).offset(-5);
        make.top.bottom.equalTo(self.bigTitleLabel);
        make.right.equalTo(self).offset(-kMargin);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------

#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.bigTitleLabel.text = textField.text;
    [self.interactor sendEventName:kTitleLabelEndEditingEvent withObjects:self.viewModel];
}

#pragma mark - --------------------Event Response--------------

- (void)setViewModel:(id<PWViewModelProtocol>)viewModel {
    [super setViewModel:viewModel];
    if ([viewModel isKindOfClass:[PWBigTitleViewModel class]]) {
        PWBigTitleViewModel *model = (PWBigTitleViewModel *)viewModel;
        self.bigTitleLabel.text = model.bigTitle;
        self.subTitleLabel.text = model.subTitle;
        
        self.textField.hidden = !model.isEditing;
        self.bigTitleLabel.hidden = model.isEditing;
    }
}

- (void)onClickBigTitle {
    if ([self.viewModel isKindOfClass:[PWBigTitleViewModel class]]) {
        PWBigTitleViewModel *viewModel = (PWBigTitleViewModel *)self.viewModel;
        viewModel.isEditing = YES;
        [self.textField becomeFirstResponder];
        [self setViewModel:self.viewModel];
        [self.interactor sendEventName:kClickBigTitleLabelEvent withObjects:self.viewModel];
    }
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
        _subTitleLabel.textColor = kWhiteColor;
    }
    return _subTitleLabel;
}

- (UILabel *)bigTitleLabel {
    if (!_bigTitleLabel) {
        _bigTitleLabel = [[UILabel alloc] init];
        _bigTitleLabel.font = [UIFont boldSystemFontOfSize:28];
        _bigTitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _bigTitleLabel.textColor = kWhiteColor;
        _bigTitleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *bigTitleLabelTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(onClickBigTitle)];
        [_bigTitleLabel addGestureRecognizer:bigTitleLabelTap];
    }
    return _bigTitleLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont boldSystemFontOfSize:28];
        _textField.backgroundColor = kLightBackgroundColor;
        _textField.textColor = kWhiteColor;
        _textField.placeholder = @"未定义标题";
        _textField.text = @"未定义标题";
        _textField.delegate = self;
        _textField.layer.cornerRadius = 10;
        _textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(5, 1, 7, 26)];
        _textField.leftViewMode = UITextFieldViewModeAlways;

#if DEBUG
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = [UIColor redColor].CGColor;
#endif
    }
    return _textField;
}

@end
