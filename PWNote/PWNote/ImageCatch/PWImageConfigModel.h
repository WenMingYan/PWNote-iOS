//
//  PWImageConfigModel.h
//  PWNote
//
//  Created by mingyan on 2019/1/8.
//  Copyright © 2019 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/SDImageCache.h>

@interface PWImageConfigModel : NSObject

@property (nonatomic, assign) SDImageCacheType cacheType;

@end
