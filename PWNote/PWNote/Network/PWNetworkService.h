//
//  PWNetworkService.h
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NetworkSuccessBlock)(NSDictionary *param);
typedef void(^NetworkFailBlock)(NSError *error);

@interface PWNetworkService : NSObject

- (void)postRequestWithMethod:(NSString *)method withParam:(NSDictionary *)param success:(NetworkSuccessBlock)successBlock fail:(NetworkFailBlock)fail;

@end

NS_ASSUME_NONNULL_END
