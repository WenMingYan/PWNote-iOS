//
//  PWNetworkService.m
//  PWNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "PWNetworkService.h"
#import <AFNetworking/AFNetworking.h>

@interface PWNetworkService ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation PWNetworkService

- (void)getRequestWithMethod:(NSString *)method
                   withParam:(NSDictionary *)param
                    progress:(NetworkProgressBlock)progressBlock
                     success:(NetworkSuccessBlock)successBlock
                        fail:(NetworkFailBlock)fail {
    //http://panyi.xyz/api/version?osType=2
    NSString *address = [NSString stringWithFormat:@"http://panyi.xyz/api/%@",method];
    NSMutableDictionary<NSString *,NSString *> *header = [NSMutableDictionary<NSString *,NSString *> dictionary];
    [self.manager GET:address parameters:param headers:header progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress);
        }
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

- (void)postRequestWithMethod:(NSString *)method
                    withParam:(NSDictionary *)param
                      success:(NetworkSuccessBlock)successBlock
                         fail:(NetworkFailBlock)fail {
    //http://panyi.xyz/api/version?osType=2
    NSMutableDictionary<NSString *,NSString *> *header = [NSMutableDictionary<NSString *,NSString *> dictionary];
    NSString *address = [NSString stringWithFormat:@"http://panyi.xyz/api/%@",method];
    [self.manager POST:address parameters:param headers:header progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"");
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

- (void)downloadWithMethod:(NSString *)method {
    //1. 创建NSURLSessionConfiguration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //2. 创建管理者对象
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    
    //3. 设置url
    //TODO: wmy url
    NSURL *url = [NSURL URLWithString:@""];//[NSURL URLWithString:@"http://127.0.0.1/1.mp4"];
    
    //4. 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //5. 下载任务
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下载进度
        NSLog(@"%lf",1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //设置下载路径
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager]URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //下载完成
        NSLog(@"File downloaded to : %@",filePath);
    }];
    //启动任务
    [downloadTask resume];
}

- (void)uploadWithMethod:(NSString *)method {
    //创建NSURLSessionConfiguration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //创建管理者对象
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    
    //设置url
    NSURL *url = [NSURL URLWithString:@""];//[NSURL URLWithString:@"http://127.0.0.1"];
    //创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //文件路径
    NSURL *filePath = [NSURL fileURLWithPath:@"file://Users/Liu/Desktop/Note"];
    
    //上传任务
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(error){
            //错误
            NSLog(@"Error:%@",error);
        }else{
            //成功
            NSLog(@"Success %@ %@",response,responseObject);
        }
    }];
    //启动任务
    [uploadTask resume];
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] init];
    }
    return _manager;
}

@end
