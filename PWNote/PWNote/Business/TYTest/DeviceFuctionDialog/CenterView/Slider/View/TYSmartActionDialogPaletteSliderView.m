//
//  TYdevice_functionValueSliderView.m
//  TuyaSmartPublic
//
//  Created by 高森 on 2017/1/9.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "TYSmartActionDialogPaletteSliderView.h"
#import <Masonry/Masonry.h>
#import "TYAlertView.h"
#import "TYDeviceFunctionDefine.h"
#import "UIView+ALMAdditons.h"
#import "UIImage+TYTrim.h"
#import "TPSlider.h"
#import "UIImage+TPAlpha.h"



@interface UIView (TYDFColor)

- (UIColor *)colorOfPoint:(CGPoint)point;

@end
@implementation UIView (TYDFColor)

- (UIColor *)colorOfPoint:(CGPoint)point {
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    [self.layer renderInContext:context];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}


@end

//TODO: wmy 图片替换路径

@interface TYSmartActionDialogPaletteSliderView () <TPSliderDelegate>

@property (nonatomic, strong) TPSlider  *slider;
@property (nonatomic, strong) UIImageView *sliderImageView; /**< 滑块进度背景颜色  */

@property (nonatomic, strong) UIButton  *subButton; /**< 减号  */
@property (nonatomic, strong) UIButton  *addButton; /**< 加号  */

@property (nonatomic, assign) BOOL      isShow;

@property (nonatomic, strong) UIView *contentView; /**< 存放数值  */

@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) NSInteger k;

@property (nonatomic, strong) NSString *units; /**< 计量单位  */
@property (nonatomic, assign) BOOL isFirst;/** < 是否是初始化*/

@end
//TODO: wmy 改名

static double MAX = 100;
static double MIN = 0;
static double STEP = 1;

@implementation TYSmartActionDialogPaletteSliderView

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)initView {
    _isShow = NO;
    [self initSubview];
    [self setImages];
    self.slider.value = self.model.originalColorProgress;
}

- (void)initSubview {
    self.clipsToBounds = NO;
    CGFloat buttonWidth = TYScreenAdaptor(44);
    
    [self addSubview:self.subButton];
    [self.subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(buttonWidth);
        make.left.mas_equalTo(TYScreenAdaptor(6));
        make.centerY.mas_equalTo(self);
    }];
    
    [self addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(buttonWidth);
        make.right.mas_equalTo(-TYScreenAdaptor(6));
        make.centerY.mas_equalTo(self);
    }];
    
    [self addSubview:self.sliderImageView];
    
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 100;
    self.slider.delegate = self;
    [self addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.mas_equalTo(TYScreenAdaptor(40));
        make.left.mas_equalTo(self.subButton.mas_right).mas_offset(TYScreenAdaptor(6));
        make.right.mas_equalTo(self.addButton.mas_left).mas_offset(-TYScreenAdaptor(6));
        make.centerX.equalTo(self);
    }];
    
    [self.sliderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.slider);
        make.height.mas_equalTo(TYScreenAdaptor(6));
        make.width.mas_equalTo(self.slider);
    }];
    self.sliderImageView.layer.cornerRadius = TYScreenAdaptor(3);
    [self addSubview:self.contentView];
}

- (void)setImages {
    self.contentView.backgroundColor = [UIColor blackColor];
    self.sliderImageView.hidden = NO;
    UIImage *proImage = [UIImage imageWithColor:[UIColor clearColor]];
    [self.slider setMinimumTrackImage:proImage forState:UIControlStateNormal];
    [self.slider setMaximumTrackImage:proImage forState:UIControlStateNormal];
    UIImage *image = [[self rainbowWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH - TYScreenAdaptor(76 * 2), TYScreenAdaptor(6))] ty_imageWithCornerRadius:TYScreenAdaptor(3)];
    self.sliderImageView.image = image;
}

+ (instancetype)deviceFunctionWithModel:(id<TYSmartActionDialogColoursModelProtocol>)model {
    TYSmartActionDialogPaletteSliderView *view = [[TYSmartActionDialogPaletteSliderView alloc] initWithDeviceFunctionModel:model];
    return view;
}

- (instancetype)initWithDeviceFunctionModel:(id<TYSmartActionDialogColoursModelProtocol>)model {
    if (self = [super init]) {
        self.model = model;
        [self initView];
    }
    return self;
}

- (UIImage *)rainbowWithFrame:(CGRect)frame {
    //底部上下渐变效果背景
    //通过图片上下文设置颜色空间间
    UIGraphicsBeginImageContext(frame.size);
    //获得当前的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //创建颜色空间 /* Create a DeviceRGB color space. */
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    //通过矩阵调整空间变换
    CGContextScaleCTM(context, frame.size.width, frame.size.height);
    //通过颜色组件获得渐变上下文
    CGGradientRef backGradient;
    CGFloat colors[] = {
        250/255.0,33/255.0,27/255.0,1.0,
        255/255.0,230/255.0,52/255.0,1.0,
        65/255.0,251/255.0,59/255.0,1.0,
        62/255.0,253/255.0,211/255.0,1.0,
        21/255.0,132/255.0,211/255.0,1.0,
        227/255.0,50/255.0,252/255.0,1.0,
        250/255.0,21/255.0,44/255.0,1.0,
    };
    backGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    //释放颜色渐变
    CGColorSpaceRelease(rgb);
    //通过上下文绘画线色渐变
    //设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    CGContextDrawLinearGradient(context, backGradient, CGPointMake(0, 0.5), CGPointMake(1, 0.5), kCGGradientDrawsBeforeStartLocation);
    //通过图片上下文获得照片
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

#pragma mark - --------------------TYSliderDelegate--------------

- (void)onSliderValueChanged:(TPSlider *)slider {
    [self updateValueLabel];
}

- (void)onSlidingComplete:(TPSlider *)slider {
    [self updateValueLabel];
    [self publishDps];
}

#pragma mark - --------------------Event Response--------------

- (void)subAction:(UIButton *)button {
    _slider.value = MAX(_slider.value - STEP, MIN);
    [self updateValueLabel];
    [self publishDps];
}

- (void)addAction:(UIButton *)button {
    _slider.value = MIN(_slider.value + STEP, MAX);
    [self updateValueLabel];
    [self publishDps];
}

#pragma mark - --------------------private methods--------------

- (UIColor *)colorInProgress:(double)progress {
    CGFloat trackHeight = TYScreenAdaptor(36);
    CGFloat width = self.slider.width - trackHeight;
    CGFloat sliderX = self.slider.left + trackHeight / 2.f + (progress - self.slider.minimumValue) / (self.slider.maximumValue - self.slider.minimumValue) * width;
    CGFloat labelWidth = TYScreenAdaptor(36);
    self.contentView.layer.cornerRadius = labelWidth * 0.5;
    CGRect frame = CGRectMake(sliderX - (labelWidth) / 2.f, -TYScreenAdaptor(10), labelWidth, labelWidth);
    self.contentView.frame = frame;
    
    double value = round(progress / STEP) * STEP;
    //FIXME: 乘以0.99是为了避免获取到的值为黑色
    CGFloat pointWidth = self.sliderImageView.width * (value - MIN)/ (MAX - MIN) * 0.99;
    if (pointWidth == 0) {
        pointWidth = 1;
    }
    CGPoint point = CGPointMake(pointWidth, TYScreenAdaptor(3));
    UIColor *color = [self.sliderImageView colorOfPoint:point];
    return color;
}


- (void)configLabelColor {
    UIColor *color = [self colorInProgress:self.slider.value];
    self.contentView.backgroundColor = color;
}

- (void)updateValueLabel {
    [self configLabelColor];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    self.currentTime = time;
    if (_contentView.hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.hidden = NO;
        } completion:^(BOOL finished) {
        }];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.currentTime == time) {
            [UIView animateWithDuration:0.3 animations:^{
                self.contentView.hidden = YES;
            }];
        }
    });
}

- (void)publishDps {
    if (self.block) {
        double value = round(self.slider.value / STEP) * STEP;
        self.block(value,self.contentView.backgroundColor);
    }
}

#pragma mark - --------------------getters & setters & init members ------------------

- (void)setModel:(id<TYSmartActionDialogColoursModelProtocol>)model {
    _model = model;
    self.slider.value = self.model.originalColorProgress;
}

- (UIImageView *)sliderImageView {
    if (!_sliderImageView) {
        _sliderImageView = [[UIImageView alloc] init];
    }
    return _sliderImageView;
}

- (TPSlider *)slider {
    if (!_slider) {
        _slider = [[TPSlider alloc] init];
        [_slider setMinimumTrackTintColor:HEXCOLOR(0xFFAB00)];
        [_slider setMaximumTrackTintColor:HEXCOLOR(0xDDDDDD)];
        [_slider setThumbImage:[UIImage imageNamed:@"ty_device_function_dot"]];
    }
    return _slider;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"ty_device_function_add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)subButton {
    if (!_subButton) {
        _subButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subButton setImage:[UIImage imageNamed:@"ty_device_function_sub"] forState:UIControlStateNormal];
        [_subButton addTarget:self action:@selector(subAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subButton;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.alpha = 0.8;
        _contentView.hidden = YES;
    }
    return _contentView;
}

@end






