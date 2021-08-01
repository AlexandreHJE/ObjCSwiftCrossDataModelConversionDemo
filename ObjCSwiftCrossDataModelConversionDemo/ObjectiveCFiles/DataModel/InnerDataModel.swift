//
//  InnerDataModel.swift
//  ObjCSwiftCrossDataModelConversionDemo
//
//  Created by Alex Hu on 2021/8/1.
//

import Foundation

@objc final class InnerDataModel_Swift: NSObject {
    var accountBalance: Int = 0
    var bonusPoint: Int = 0
    var coins: Int = 0
    
    convenience init(_ accountBalance: Int, _ bonusPoint: Int, _ coins: Int) {
        self.init()
        self.accountBalance = accountBalance
        self.bonusPoint = bonusPoint
        self.coins = coins
    }
    
    @objc func initWithOBJCModel(with object: InnerDataModel_Swift) -> Self {
        let accountBalance = object.accountBalance
        let bonusPoint = object.bonusPoint
        let coins = object.coins
        
        return InnerDataModel_Swift(accountBalance, bonusPoint, coins) as! Self
    }
    
    @objc func newInstance(attributes: Dictionary<NSObject, AnyObject>) -> InnerDataModel_Swift {
        let returnModel: InnerDataModel_Swift = InnerDataModel_Swift()
        if let attributes = attributes as? [String: AnyObject] {
            if let accountBalance = (attributes["accountBalance"] as? NSString)?.integerValue,
               let bonusPoint = (attributes["bonusPoint"] as? NSString)?.integerValue,
               let coins = (attributes["coins"] as? NSString)?.integerValue {
                returnModel.updateObjectDataContent(accountBalance, bonusPoint, coins)
            }
        }
        return returnModel
    }
    
    private func updateObjectDataContent(_ accountBalance: Int, _ bonusPoint: Int, _ coins: Int) {
        self.accountBalance = accountBalance
        self.bonusPoint = bonusPoint
        self.coins = coins
    }
    
    func convertClassToStruct() -> InnerDataModel_Struct {
        return InnerDataModel_Struct(accountBalance: accountBalance, bonusPoint: bonusPoint, coins: coins)
    }
}

struct InnerDataModel_Struct {
    var accountBalance: Int = 0
    var bonusPoint: Int = 0
    var coins: Int = 0
}
