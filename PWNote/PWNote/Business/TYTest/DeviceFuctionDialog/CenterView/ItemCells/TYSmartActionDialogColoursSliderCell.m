//
//  TYDFColoursSliderCell.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogColoursSliderCell.h"
#import <Masonry/Masonry.h>
#import "TYSmartActionDialogPaletteSliderView.h"
#import "TYDeviceFunctionDefine.h"

@interface  TYSmartActionDialogColoursSliderCell ()

@property (nonatomic, strong) TYSmartActionDialogPaletteSliderView *sliderView;

@end

@implementation TYSmartActionDialogColoursSliderCell

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
    _sliderView = [[TYSmartActionDialogPaletteSliderView alloc] initWithDeviceFunctionModel:self.model];
    [self addSubview:self.sliderView];
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(TYScreenAdaptor(90));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)setBlock:(SliderDialogColoursCallback)block {
    self.sliderView.block = [block copy];
}

- (void)setModel:(id<TYSmartActionDialogColoursModelProtocol>)model {
    _model = model;
    self.sliderView.model = model;
}

@end
