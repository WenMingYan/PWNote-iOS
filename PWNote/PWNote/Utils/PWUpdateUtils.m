//
//  PWUpdateUtils.m
//  PWNote
//
//  Created by mingyan on 2018/12/25.
//  Copyright © 2018 明妍. All rights reserved.
//  

#import "PWUpdateUtils.h"
#import "PWNetworkService.h"
#import "PWApplicationMessages.h"

@implementation PWUpdateUtils

+ (void)checkUpdateWithSuccess:(void(^)(BOOL canUpdate,NSString *updateAdd))success
                          fail:(void(^)(NSError *err))fail {
    PWNetworkService *service = [[PWNetworkService alloc] init];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"osType"] = @(1);
    [service postRequestWithMethod:@"version"
                         withParam:param
                           success:^(NSDictionary * _Nonnull param) {
                               NSLog(@"");
                               NSDictionary *dataDict = param[@"data"];
                               NSString *versionName = [self versionWithString:dataDict[@"versionName"]];
                               NSString *url = dataDict[@"url"];
                               NSString *currentVersion = [self versionWithString:[[PWApplicationMessages sharedInstance] version]];
                               if (versionName.longLongValue > currentVersion.longLongValue) {
                                   if (success) {
                                       success(YES,url);
                                   }
                               } else {
                                   if (success) {
                                       success(NO,nil);
                                   }
                               }
                           } fail:^(NSError * _Nonnull error) {
                               if (fail) {
                                   fail(error);
                               }
                               
                           }];
}

+ (NSString *)versionWithString:(NSString *)string {
    NSArray *strs = [string componentsSeparatedByString:@"."];
    NSMutableString *result = [NSMutableString string];
    for (NSString *str in strs) {
        [result appendString:[NSString stringWithFormat:@"%03ld",str.integerValue]];
    }
    return result;
}

@end
