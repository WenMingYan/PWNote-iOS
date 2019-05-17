//
//  TYDFColoursSliderView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/10.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogColoursSaturabilitySliderView.h"
#import <Masonry/Masonry.h>
#import "TYSmartActionDialogPaletteSliderView.h"
#import "TYSmartActionDialogNumericSliderView.h"
#import "TYDeviceFunctionDefine.h"

@interface TYSmartActionDialogColoursSaturabilitySliderView ()

@property (nonatomic, strong) TYSmartActionDialogPaletteSliderView *colorSliderView;
@property (nonatomic, strong) TYSmartActionDialogNumericSliderView *saturabilitySliderView;

@end

@implementation TYSmartActionDialogColoursSaturabilitySliderView

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)setModel:(id<TYDDFSliderColoursSaturabilityModelProtocol>)model {
    _model = model;
    _colorSliderView.model = model.coloursModel;
    _saturabilitySliderView.model = model.saturabilityModel;
}

- (void)initView {
    _colorSliderView = [[TYSmartActionDialogPaletteSliderView alloc] initWithDeviceFunctionModel:self.model.coloursModel];
    _saturabilitySliderView = [[TYSmartActionDialogNumericSliderView alloc] initWithDeviceFunctionModel:self.model.saturabilityModel];
    [self addSubview:_colorSliderView];
    [self addSubview:_saturabilitySliderView];
    
    [_colorSliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.centerX.equalTo(self);
        make.top.mas_equalTo(TYScreenAdaptor(33));
        make.left.mas_equalTo(TYScreenAdaptor(5));
        make.height.mas_equalTo(TYScreenAdaptor(90));
    }];
    [_saturabilitySliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.centerX.equalTo(self);
        make.top.equalTo(self.colorSliderView.mas_bottom);
        make.left.mas_equalTo(TYScreenAdaptor(5));
        make.height.mas_equalTo(TYScreenAdaptor(90));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

+ (instancetype)silderViewWithModel:(id<TYDDFSliderColoursSaturabilityModelProtocol>)model {
    TYSmartActionDialogColoursSaturabilitySliderView *view = [[TYSmartActionDialogColoursSaturabilitySliderView alloc] initSilderViewWithModel:model];
    return view;
}

- (instancetype)initSilderViewWithModel:(id<TYDDFSliderColoursSaturabilityModelProtocol>)model {
    if (self = [super init]) {
        self.model = model;
        self.model.saturabilityModel.modelType = TYSmartActionDialogNumberModelType_Saturability;
        [self initView];
    }
    return self;
}

#pragma mark - --------------------Event Response--------------

- (UIColor *)colorInProgress:(double)progress {
    return [_colorSliderView colorInProgress:progress];
}

#pragma mark - --------------------getters & setters & init members ------------------

- (void)setSaturabilityCallback:(SliderDialogNumCallback)saturabilityCallback {
    _saturabilityCallback = saturabilityCallback;
    _saturabilitySliderView.block = saturabilityCallback;
}

- (void)setColoursCallback:(SliderDialogColoursCallback)coloursCallback {
    _coloursCallback = coloursCallback;
    _colorSliderView.block = coloursCallback;
}

@end
