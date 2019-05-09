//
//  TPSlider.h
//  TYLibraryExample
//
//  Created by 冯晓 on 2017/4/24.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPSlider;

@protocol TPSliderDelegate <NSObject>

@required
- (void)onSliderValueChanged:(TPSlider *)slider;
- (void)onSlidingComplete:(TPSlider *)slider;

@end

@interface TPSlider : UISlider

@property (nonatomic, weak) id <TPSliderDelegate> delegate;
@property (nonatomic, assign) float step;
@property (nonatomic, strong) UIImage *minimumTrackImage;
@property (nonatomic, strong) UIImage *maximumTrackImage;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, assign) CGFloat trackHeight;

- (void)resizeTrackImageView;
- (void)removeAllTrackImage;

@end



