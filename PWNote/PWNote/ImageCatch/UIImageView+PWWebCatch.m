//
//  UIImageView+PWWebCatch.m
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "UIImageView+PWWebCatch.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (PWWebCatch)

- (void)pw_setImageViewWithUrlString:(NSString *)imageUrl {
    [self pw_setImageViewWithUrlString:imageUrl plackholderImage:nil progressBlock:nil withCompleteBlock:nil];
}

- (void)pw_setImageViewWithUrlString:(NSString *)imageUrl withCompleteBlock:(CompleteBlock)block {
    [self pw_setImageViewWithUrlString:imageUrl plackholderImage:nil progressBlock:nil withCompleteBlock:block];
}

- (void)pw_setImageViewWithUrlString:(NSString *)imageUrl plackholderImage:(UIImage *)image {
    [self pw_setImageViewWithUrlString:imageUrl plackholderImage:image progressBlock:nil withCompleteBlock:nil];
}

- (void)pw_setImageViewWithUrlString:(NSString *)imageUrl plackholderImage:(UIImage *)image
                       progressBlock:(ProgressBlock)progressBlock withCompleteBlock:(CompleteBlock)block {
    NSURL *url = [NSURL URLWithString:imageUrl];
    [self sd_setImageWithURL:url placeholderImage:image
                     options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                         if (progressBlock) {
                             progressBlock(receivedSize,expectedSize,targetURL.absoluteString);
                         }
                     } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                         if (block) {
                             PWImageConfigModel *model = [[PWImageConfigModel alloc] init];
                             block(!error,image,model);
                         }
                     }];
}

@end
