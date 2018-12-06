//
//  PWNetworkService.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWNetworkService.h"
#import <AFNetworking/AFNetworking.h>

@implementation PWNetworkService

- (void)postRequestWithMethod:(NSString *)method
                    withParam:(NSDictionary *)param
                      success:(NetworkSuccessBlock)successBlock
                         fail:(NetworkFailBlock)fail {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    NSString *address = [NSString stringWithFormat:@"http://panyi.xyz/api/%@",method];
    
    [manager POST:address parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    
}

@end
