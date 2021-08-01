//
//  InnerDataModel.h
//  ObjCSwiftCrossDataModelConversionDemo
//
//  Created by Alex Hu on 2021/8/1.
//

#import <Foundation/Foundation.h>
//@class ListInfoCashModel_Swift;

@interface InnerDataModel : NSObject

@property  (nonatomic,copy) NSDictionary *original;

@property (readonly , nonatomic) NSInteger accountBalance;
@property (readonly , nonatomic) NSInteger bonusPoint;
@property (readonly , nonatomic) NSInteger coins;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
//- (ListInfoCashModel_Swift *)convertToSwiftVersionObject: (ListInfoCashModel *)modelObject;

@end

