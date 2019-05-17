//
//  TYDFSliderCollectionView.m
//  PWNote
//
//  Created by 温明妍 on 2019/5/11.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "TYSmartActionDialogNumberSliderCell.h"
#import <Masonry/Masonry.h>
#import "TYSmartActionDialogNumericSliderView.h"
#import "TYDeviceFunctionDefine.h"
//TODO: wmy to delete
#import <RACEXTScope.h>

@interface TYSmartActionDialogNumberSliderCell ()

@property (nonatomic, strong) TYSmartActionDialogNumericSliderView *view;

@end

@implementation TYSmartActionDialogNumberSliderCell

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
    _view = [[TYSmartActionDialogNumericSliderView alloc] initWithDeviceFunctionModel:self.model];
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(TYScreenAdaptor(90));
    }];
    @weakify(self);
    _view.block = ^(double number) {
        @strongify(self);
        if (self.callback) {
            self.callback(number);
        }
    };
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)setModel:(id<TYSmartActionDialogNumberModelProtocol>)model {
    _model = model;
    self.view.model = model;
}

@end
