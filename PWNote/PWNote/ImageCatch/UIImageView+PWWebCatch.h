//
//  UIImageView+PWWebCatch.h
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWImageConfigModel.h"

typedef void(^CompleteBlock)(BOOL success, UIImage *image, PWImageConfigModel *model);
typedef void(^ProgressBlock)(NSInteger progress, NSInteger total,NSString *imageUrl);

@interface UIImageView (PWWebCatch)

- (void)pw_setImageViewWithUrlString:(NSString *)imageUrl;

- (void)pw_setImageViewWithUrlString:(NSString *)imageUrl plackholderImage:(UIImage *)image;

- (void)pw_setImageViewWithUrlString:(NSString *)imageUrl withCompleteBlock:(CompleteBlock)block;

- (void)pw_setImageViewWithUrlString:(NSString *)imageUrl plackholderImage:(UIImage *)image
                       progressBlock:(ProgressBlock)progressBlock withCompleteBlock:(CompleteBlock)block;

@end
