//
//
// NSError+MessageError.m
// ObjCSwiftCrossDataModelConversionDemo
//
// Created by Alexandre Hu (HU JEN EN) on 2021/7/30
// Copyright © 2021 Alexandre Hu. All rights reserved.
//
        
#import "NSError+MessageError.h"

#define DomainName @"AppErrorDomain"

@implementation NSError (MessageError)

+(instancetype)errorWithCode:(NSInteger)code message:(NSString*)message;
{
    return [[[self class] alloc] initWithCode:code message:message];
}

-(instancetype)initWithCode:(NSInteger)code message:(NSString*)message;
{
    NSMutableDictionary * userInfo = [NSMutableDictionary dictionary];
    [userInfo setValue:message forKey:NSLocalizedDescriptionKey];
    
    return [self initWithDomain:DomainName code:code userInfo:userInfo];
}

@end
