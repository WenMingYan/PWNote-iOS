//
//  TYDFColoursSaturabilityInCell.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogColoursSaturabilityIntensityCell.h"
#import <Masonry/Masonry.h>
#import "TYSmartActionDialogColoursSaturabilityIntensitySliderView.h"

@interface TYSmartActionDialogColoursSaturabilityIntensityCell ()

@property (nonatomic, strong) TYSmartActionDialogColoursSaturabilityIntensitySliderView *view;

@end

@implementation TYSmartActionDialogColoursSaturabilityIntensityCell

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
    _view = [[TYSmartActionDialogColoursSaturabilityIntensitySliderView alloc] initSliderViewWithModel:self.model];
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

#pragma mark - --------------------getters & setters & init members ------------------

- (void)setModel:(id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>)model {
    _model = model;
    _view.model = model;
    
    _saturabilityValue = model.saturabilityModel.dialogStartValue;
    _intensityValue = model.intensityModel.dialogStartValue;
    _colorProgress = model.coloursModel.originalColorProgress;
    _color = [_view colorInProgress:model.coloursModel.originalColorProgress];
}

- (void)setColoursCallback:(SliderDialogColoursCallback)coloursCallback {
    _view.coloursCallback = [coloursCallback copy];
}

- (void)setSaturabilityCallback:(SliderDialogNumCallback)saturabilityCallback {
    _view.saturabilityCallback = [saturabilityCallback copy];
}

- (void)setIntensityCallback:(SliderDialogNumCallback)intensityCallback {
    _view.intensityCallback = [intensityCallback copy];
}

@end
