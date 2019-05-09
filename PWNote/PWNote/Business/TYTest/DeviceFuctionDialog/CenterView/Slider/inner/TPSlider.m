//
//  TPSlider.m
//  TYLibraryExample
//
//  Created by 冯晓 on 2017/4/24.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "TPSlider.h"
//#import "UIView+TPAdditions.h"
//#import "TPViewConstants.h"
#import "UIView+ALMAdditons.h"
#import "TYDeviceFunctionDefine.h"



@interface TPSlider() {
    BOOL _slidingLock;
}

@property (nonatomic, strong) UIImageView *minimumTrackImageView;
@property (nonatomic, strong) UIImageView *maximumTrackImageView;

@end

@implementation TPSlider

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTap:)];
        [self addGestureRecognizer:tapRecognizer];
        
        [self addTarget:self action:@selector(sliderTouchStart:) forControlEvents:UIControlEventTouchDown];
        
        [self addTarget:self action:@selector(sliderTouchEnd:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        
        [self addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        _slidingLock = false;
    }
    return self;
}

- (void)setValue:(float)value {
    super.value = value;
    [self setMinimumTrackProcess];
}

- (void)setMinimumValue:(float)minimumValue {
    super.minimumValue = minimumValue;
    [self setMinimumTrackProcess];
}

- (void)setMaximumValue:(float)maximumValue {
    super.maximumValue = maximumValue;
    [self setMinimumTrackProcess];
}

- (void)sliderTap:(UIGestureRecognizer *)recognizer {
    if (_slidingLock) return;
    if (self.enabled) {
        CGPoint point = [recognizer locationInView:self];
        self.value = point.x / self.width * (self.maximumValue - self.minimumValue) + self.minimumValue;
        [self sendSliderEvent:self continuous:NO];
    }
}

- (IBAction)sliderTouchStart:(TPSlider *)sender {
    _slidingLock = YES;
}

- (IBAction)sliderTouchEnd:(TPSlider *)sender {
    [self sendSliderEvent:self continuous:NO];
    _slidingLock = NO;
}

- (IBAction)sliderValueChanged:(TPSlider *)sender {
    [self sendSliderEvent:self continuous:YES];
}

- (void)sendSliderEvent:(TPSlider *)sender continuous:(BOOL)continuous {
    if (sender.step > 0 && sender.step <= (sender.maximumValue - sender.minimumValue)) {
        self.value = MAX(sender.minimumValue, MIN(sender.maximumValue, sender.minimumValue + round((sender.value - sender.minimumValue) / sender.step) * sender.step));
    } else {
        [self setMinimumTrackProcess];
    }
    if (continuous) {
        if ([self.delegate respondsToSelector:@selector(onSliderValueChanged:)]) {
            [self.delegate onSliderValueChanged:sender];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(onSlidingComplete:)]) {
            [self.delegate onSlidingComplete:sender];
        }
    }
}

- (void)setMinimumTrackProcess {
    if (_minimumTrackImage) {
        if (self.maximumValue > self.minimumValue) {
            _minimumTrackImageView.width = (self.value - self.minimumValue) / (self.maximumValue - self.minimumValue) * _minimumTrackImageView.image.size.width;
        } else {
            _minimumTrackImageView.width = 0;
        }
    }
}

- (void)resizeTrackImageView {
    if (_minimumTrackImage) {
        self.minimumTrackImageView.left = (self.width - _minimumTrackImage.size.width) / 2;
        self.minimumTrackImageView.top = (self.height - _minimumTrackImage.size.height) / 2;
    }
    if (_maximumTrackImage) {
        self.maximumTrackImageView.left = (self.width - _maximumTrackImage.size.width) / 2;
        self.maximumTrackImageView.top = (self.height - _maximumTrackImage.size.height) / 2;
    }
}

- (UIImageView *)minimumTrackImageView {
    if (!_minimumTrackImageView) {
        _minimumTrackImageView = [[UIImageView alloc] init];
        _minimumTrackImageView.layer.masksToBounds = YES;
        _minimumTrackImageView.contentMode = UIViewContentModeLeft;
    }
    return _minimumTrackImageView;
}

- (UIImageView *)maximumTrackImageView {
    if (!_maximumTrackImageView) {
        _maximumTrackImageView = [[UIImageView alloc] init];
        _maximumTrackImageView.contentMode = UIViewContentModeLeft;
    }
    return _maximumTrackImageView;
}

- (void)removeAllTrackImage {
    self.minimumTrackTintColor = nil;
    [_minimumTrackImageView removeFromSuperview];
    _minimumTrackImage = nil;
    _minimumTrackImageView = nil;
    self.maximumTrackTintColor = nil;
    [_maximumTrackImageView removeFromSuperview];
    _maximumTrackImage = nil;
    _maximumTrackImageView = nil;
}

- (void)setMinimumTrackImage:(UIImage *)minimumTrackImage {
    if (minimumTrackImage) {
        _minimumTrackImage = minimumTrackImage;
        self.minimumTrackTintColor = [UIColor clearColor];
        // http://stackoverflow.com/questions/22522486/uislider-minimum-and-maximum-track-tint-clear-color-ios-7-1-bug
        if (TP_SYSTEM_VERSION < 8.0) {
            [self setMinimumTrackImage:[[UIImage alloc] init] forState:UIControlStateNormal];
        }
        self.minimumTrackImageView.image = minimumTrackImage;
        self.minimumTrackImageView.size = minimumTrackImage.size;
        self.minimumTrackImageView.left = (self.width - minimumTrackImage.size.width) / 2;
        self.minimumTrackImageView.top = (self.height - minimumTrackImage.size.height) / 2;
        if (_maximumTrackImageView) {
            [self insertSubview:self.minimumTrackImageView aboveSubview:_maximumTrackImageView];
        } else {
            [self insertSubview:self.minimumTrackImageView atIndex:0];
        }
        [self setMinimumTrackProcess];
    } else {
        self.minimumTrackTintColor = nil;
        [_minimumTrackImageView removeFromSuperview];
        _minimumTrackImage = nil;
        _minimumTrackImageView = nil;
    }
}

- (void)setMaximumTrackImage:(UIImage *)maximumTrackImage {
    if (maximumTrackImage) {
        _maximumTrackImage = maximumTrackImage;
        self.maximumTrackTintColor = [UIColor clearColor];
        self.maximumTrackImageView.image = maximumTrackImage;
        self.maximumTrackImageView.size = maximumTrackImage.size;
        self.maximumTrackImageView.left = (self.width - maximumTrackImage.size.width) / 2;
        self.maximumTrackImageView.top = (self.height - maximumTrackImage.size.height) / 2;
        [self insertSubview:self.maximumTrackImageView atIndex:0];
    } else {
        self.maximumTrackTintColor = nil;
        [_maximumTrackImageView removeFromSuperview];
        _maximumTrackImage = nil;
        _maximumTrackImageView = nil;
    }
}

- (void)setThumbImage:(UIImage *)thumbImage {
    [self setThumbImage:thumbImage forState:UIControlStateNormal];
}

- (UIImage *)thumbImage {
    return [self thumbImageForState:UIControlStateNormal];
}

- (CGRect)trackRectForBounds:(CGRect)bounds {
    bounds = [super trackRectForBounds:bounds];
    if (self.trackHeight > 0) {
        bounds.size.height = self.trackHeight;
    }
    return bounds;
}

@end

