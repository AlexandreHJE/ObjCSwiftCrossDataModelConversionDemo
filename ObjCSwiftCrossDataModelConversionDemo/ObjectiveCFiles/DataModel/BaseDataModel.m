//
//  BaseDataModel.m
//  ObjCSwiftCrossDataModelConversionDemo
//
//  Created by Alex Hu on 2021/8/1.
//

#import "Utilities.h"
#import "BaseDataModel.h"
#import "APIClient.h"

#define API_PATH    @"MemberInfo/MemberBalance"

@implementation BaseDataModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    _original = attributes;
    _memberID = [[attributes objectForKey:@"memberID"] intValue];
    _rtnCode = [[attributes objectForKey:@"rtnCode"] intValue];
    _rtnData = [attributes objectForKey:@"rtnData"];

    //防呆
    if ([attributes objectForKey:@"rtnMessage"] && ![[attributes objectForKey:@"rtnMessage"] isEqual:[NSNull null]]) {
        _rtnMsg = [attributes objectForKey:@"rtnMessage"];
    }else{
        _rtnMsg = @"";
    }
    
    return self;
}

+ (NSURLSessionDataTask *)action:(void (^)(BaseDataModel *, NSError *))block {
    AFHTTPSessionManager *manager = [APIClient sharedInstance];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"memberID": @"1" };
    
    return [manager POST: @"https://80d418d5-ef8f-46d8-8112-0aab02914e63.mock.pstmn.io?memeberID=1" parameters:parameters headers:nil progress:nil
                 success: ^(NSURLSessionDataTask *operation, id responseObject) {
        
        id data = responseObject;
        id sss = [data objectForKey:@"rtnCode"];
        
        BaseDataModel *returnObject = [[[self class] alloc] initWithAttributes:sss];
        if (block) {
            block(returnObject, nil);
        }
    }
                 failure:^(NSURLSessionDataTask *operation , NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

@end
