//
//  InnerDataModel.m
//  ObjCSwiftCrossDataModelConversionDemo
//
//  Created by Alex Hu on 2021/8/1.
//

#import "InnerDataModel.h"

@implementation InnerDataModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }

    _original = attributes;
    _accountBalance = [[attributes objectForKey:@"accountBalance"] integerValue];
    _bonusPoint = [[attributes objectForKey:@"bonusPoint"] integerValue];
    _coins = [[attributes objectForKey:@"coins"] integerValue];

    return self;
}


@end
