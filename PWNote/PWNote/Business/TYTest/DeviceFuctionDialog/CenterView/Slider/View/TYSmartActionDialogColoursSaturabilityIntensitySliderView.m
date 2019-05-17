//
//  TYDFColoursSaturabilityIntensitySliderView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogColoursSaturabilityIntensitySliderView.h"
#import <Masonry/Masonry.h>
#import "TYSmartActionDialogPaletteSliderView.h"
#import "TYDeviceFunctionDefine.h"
#import "TYSmartActionDialogNumericSliderView.h"

@interface TYSmartActionDialogColoursSaturabilityIntensitySliderView ()



@property (nonatomic, strong) TYSmartActionDialogPaletteSliderView *coloursView; /**< 色彩  */
@property (nonatomic, strong) TYSmartActionDialogNumericSliderView *saturabilityView; /**< 饱和度  */
@property (nonatomic, strong) TYSmartActionDialogNumericSliderView *intensityView; /**< 亮度  */

@end

@implementation TYSmartActionDialogColoursSaturabilityIntensitySliderView

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)initView {
    _coloursView = [[TYSmartActionDialogPaletteSliderView alloc] initWithDeviceFunctionModel:self.model.coloursModel];
    _saturabilityView = [[TYSmartActionDialogNumericSliderView alloc] initWithDeviceFunctionModel:self.model.saturabilityModel];
    _intensityView = [[TYSmartActionDialogNumericSliderView alloc] initWithDeviceFunctionModel:self.model.intensityModel];
    [self addSubview:_coloursView];
    [self addSubview:_saturabilityView];
    [self addSubview:_intensityView];
    [_coloursView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);

        make.height.mas_equalTo(TYScreenAdaptor(90));
    }];
    [_saturabilityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.coloursView.mas_bottom);
        make.height.mas_equalTo(TYScreenAdaptor(90));
    }];
    [_intensityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.saturabilityView.mas_bottom);
        make.height.mas_equalTo(TYScreenAdaptor(90));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}
- (instancetype)initSliderViewWithModel:(id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>)model {
    if (self = [super init]) {
        self.model = model;
        [self initView];
    }
    return self;
}

+ (instancetype)sliderViewWithModel:(id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>)model {
    TYSmartActionDialogColoursSaturabilityIntensitySliderView *view = [[self alloc] initSliderViewWithModel:model];
    return view;
}

- (UIColor *)colorInProgress:(double)progress {
    return [_coloursView colorInProgress:progress];
}

#pragma mark - --------------------getters & setters & init members ------------------

- (void)setModel:(id<TYSmartActionDialogSliderColoursSaturabilityIntensityModelProtocol>)model {
    _model = model;
    self.coloursView.model = model.coloursModel;
    self.intensityView.model = model.intensityModel;
    self.saturabilityView.model = model.saturabilityModel;
}

- (void)setSaturabilityCallback:(SliderDialogNumCallback)saturabilityCallback {
    _saturabilityCallback = saturabilityCallback;
    _saturabilityView.block = saturabilityCallback;
}

- (void)setColoursCallback:(SliderDialogColoursCallback)coloursCallback {
    _coloursCallback = coloursCallback;
    _coloursView.block = coloursCallback;
}

- (void)setIntensityCallback:(SliderDialogNumCallback)intensityCallback {
    _intensityCallback = intensityCallback;
    _intensityView.block = intensityCallback;
}

@end
