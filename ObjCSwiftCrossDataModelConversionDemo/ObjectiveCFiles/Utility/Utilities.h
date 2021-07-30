//
//
// Utilities.h
// ObjCSwiftCrossDataModelConversionDemo
//
// Created by Alexandre Hu (HU JEN EN) on 2021/7/30
// Copyright © 2021 Alexandre Hu. All rights reserved.
//
        
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+(NSString *)getErrorMessage:(NSString *)pDesc code:(NSString *)pCode;

+(NSString *) json_encodeWithObj: (id)obj error:(NSError **)error;
+(NSString *) json_encode: (NSDictionary *)dict error:(NSError **)error;
+(NSDictionary *) json_decode : (NSString *)str error:(NSError **)error;

+(BOOL)isJBDevice;
@end
