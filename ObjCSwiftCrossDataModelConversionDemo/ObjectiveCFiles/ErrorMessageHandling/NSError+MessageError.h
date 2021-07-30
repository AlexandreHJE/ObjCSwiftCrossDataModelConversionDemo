//
//
// NSError+MessageError.h
// ObjCSwiftCrossDataModelConversionDemo
//
// Created by Alexandre Hu (HU JEN EN) on 2021/7/30
// Copyright © 2021 Alexandre Hu. All rights reserved.
//
        

#import <Foundation/Foundation.h>

@interface NSError (MessageError)

+(id)errorWithCode:(NSInteger)code message:(NSString*)message;
-(id)initWithCode:(NSInteger)code message:(NSString*)message;

@end
