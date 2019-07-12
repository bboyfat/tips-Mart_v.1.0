//
//  Filter.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/11/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import UIKit

protocol FilterProtocol {
    func filter(categories: [Int], online: Bool?) -> [ShopDataRealm]
    func getOnlineCount() -> Int
    func getOfflineCount() -> Int
    func getShopsByCatCount(_ category: Int) -> Int
}


class Filter: FilterProtocol{
    
    var model: [ShopDataRealm]!
    
    func getOnlineCount() -> Int{
        var array: [ShopDataRealm] = []
        model.forEach { (shop) in
            
            if shop.type == "online"{
                array.append(shop)
            }
        }
        return array.count
    }
    func getOfflineCount() -> Int{
        var array: [ShopDataRealm] = []
        model.forEach { (shop) in
            if shop.type == "offline"{
                array.append(shop)
            }
        }
        return array.count
    }
    func allShopsCount() -> Int{
        return model.count
    }
    
    func getShopsByCatCount(_ category: Int) -> Int{
        var array: [ShopDataRealm] = []
        model.forEach { (shop) in
            if shop.categories.contains(category){
                array.append(shop)
            }
        }
        
        return array.count
    }
    
    
    
    
    func filter(categories: [Int], online: Bool?) -> [ShopDataRealm] {
        
        return model.filter { (shop) -> Bool in
            var isMatched: Bool = false
            categories.forEach({ (category) in
                shop.categories.forEach({ (shopCat) in
                    if shopCat == category  {
                        guard let online = online else { isMatched = true; return}
                        #warning("don't forget about isOnline param")
                        if shop.isSelected == online {
                            isMatched = true
                        }
                    }
                })
            })
            return isMatched
        }
    }
    func fetchShops(model: [ShopDataRealm]){
        self.model = model
    }
    
    init(model: [ShopDataRealm]) {
        fetchShops(model: model)
    }
    
}
