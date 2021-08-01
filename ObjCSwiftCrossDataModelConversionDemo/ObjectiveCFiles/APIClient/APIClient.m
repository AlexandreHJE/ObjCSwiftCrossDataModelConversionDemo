//
//  APIClient.m
//  ObjCSwiftCrossDataModelConversionDemo
//
//  Created by Alex Hu on 2021/8/1.
//

#import "APIClient.h"
#import "AFURLResponseSerialization.h"
#import "Utilities.h"

static NSString * const API_Base_URLString = @"https://80d418d5-ef8f-46d8-8112-0aab02914e63.mock.pstmn.io/";

@implementation APIClient

+ (instancetype)sharedInstance {
    //    static AllpayAPIClient *instance = nil;
    //    static dispatch_once_t onceToken;
    //        dispatch_once(&onceToken, ^{
    //            instance = [[AllpayAPIClient alloc] ini]
    //            instance = [[AllpayAPIClient sharedClientWithType:type timeoutSecond:20] init];
    //        });
    //    return instance;
    static APIClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[APIClient alloc] init];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[
            @"text/html",
            @"text/plain",
            @"text/xml",
            @"application/json",
            @"application/rss+xml",
            @"application/xml"]];
    });
    
    return instance;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress *))uploadProgress
                      success:(void (^)(NSURLSessionDataTask *, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure
{
    return [self POST:URLString parameters:parameters headers:nil
             progress:uploadProgress
              success:success
              failure:failure];
}

@end
