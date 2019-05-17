//
//  TYDFColoursSaturabilityCell.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogColoursSaturabilityCell.h"
#import "TYSmartActionDialogColoursSaturabilitySliderView.h"
#import <Masonry/Masonry.h>

@interface TYSmartActionDialogColoursSaturabilityCell ()

@property (nonatomic, strong) TYSmartActionDialogColoursSaturabilitySliderView *view;

@end

@implementation TYSmartActionDialogColoursSaturabilityCell


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
    _view = [[TYSmartActionDialogColoursSaturabilitySliderView alloc] initSilderViewWithModel:self.model];
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (void)setColoursCallback:(SliderDialogColoursCallback)coloursCallback {
    _view.coloursCallback = [coloursCallback copy];
}

- (void)setSaturabilityCallback:(SliderDialogNumCallback)saturabilityCallback {
    _view.saturabilityCallback = [saturabilityCallback copy];
}

- (void)setModel:(id<TYDDFSliderColoursSaturabilityModelProtocol>)model {
    _model = model;
    _view.model = model;
    
    _saturabilityValue = model.saturabilityModel.dialogStartValue;
    _colorProgress = model.coloursModel.originalColorProgress;
    _color = [_view colorInProgress:model.coloursModel.originalColorProgress];
}

@end
