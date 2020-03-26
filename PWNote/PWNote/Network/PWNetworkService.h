//
//  PWNetworkService.h
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NetworkProgressBlock)(NSProgress *progress);
typedef void(^NetworkSuccessBlock)(NSDictionary *param);
typedef void(^NetworkFailBlock)(NSError *error);

typedef enum : NSUInteger {
    PWNetworkReachabilityStatusUnknown,
    PWNetworkReachabilityStatusNotReachable,
    PWNetworkReachabilityStatusReachableViaWWAN,
    PWNetworkReachabilityStatusReachableViaWiFi,
} PWNetworkReachabilityStatus;

@interface PWNetworkService : NSObject

@property (nonatomic, assign, readonly) PWNetworkReachabilityStatus status;/** < 当前网络状态*/
/// get请求
/// @param method 方法
/// @param param 参数
/// @param progressBlock 过程参数
/// @param successBlock 成功参数
/// @param fail 失败参数
- (void)getRequestWithMethod:(NSString *)method
                   withParam:(NSDictionary *)param
                    progress:(NetworkProgressBlock)progressBlock
                     success:(NetworkSuccessBlock)successBlock
                        fail:(NetworkFailBlock)fail;


/// post情趣
/// @param method 方法
/// @param param 参数
/// @param successBlock 成功参数
/// @param fail   失败参数
- (void)postRequestWithMethod:(NSString *)method
                    withParam:(NSDictionary *)param
                      success:(NetworkSuccessBlock)successBlock
                         fail:(NetworkFailBlock)fail;

//TODO: wmy 未完成
- (void)downloadWithMethod:(NSString *)method;

- (void)uploadWithMethod:(NSString *)method;

@end

NS_ASSUME_NONNULL_END
