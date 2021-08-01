//
//  BaseDataModel.h
//  ObjCSwiftCrossDataModelConversionDemo
//
//  Created by Alex Hu on 2021/8/1.
//

#import <Foundation/Foundation.h>
#import "NSError+MessageError.h"
#import "AFHTTPSessionManager.h"

@interface BaseDataModel : NSObject

@property (readonly, nonatomic) NSInteger memberID;
@property (readonly, nonatomic) NSInteger rtnCode;
@property (readonly, nonatomic) NSString *rtnMsg;
@property (readonly, nonatomic) NSString *rtnData;

@property  (nonatomic,copy) NSDictionary *original;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (NSURLSessionDataTask *)action:(void (^)(BaseDataModel *dataInfo, NSError *error))block;

//+ (NSURLSessionDataTask *)getInfoCash:(void (^)(ListInfoCashModel_Swift *dataInfo, NSError *error))block;
@end

