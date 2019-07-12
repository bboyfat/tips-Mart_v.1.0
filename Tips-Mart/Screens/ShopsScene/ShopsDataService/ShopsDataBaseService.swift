//
//  ShopsDataBaseService.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/10/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import RealmSwift
protocol ShopsDataBaseProtocol {
    func saveShopsToData()
}

class ShopsDataBaseService: ShopsDataBaseProtocol{
    
    var model: [ShopsModel]!
    //Saving shops to realm
    func saveShopsToData(){
        model.forEach({ (shop) in
            let shopsRealmData = ShopDataRealm()
            shopsRealmData.setValue(shop.pathToShop, forKey: "url")
            shopsRealmData.setValue(shop.type, forKey: "type")
            shopsRealmData.setValue(shop.shopID, forKey: "shopID")
            shopsRealmData.setValue(shop.pathToImage, forKey: "pathImage")
            shopsRealmData.setValue(shop.name, forKey: "name")
            shopsRealmData.setValue(shop.categories, forKey: "categories")
            shopsRealmData.setValue(shop.maxCashback.typeCurrency, forKey: "currency")
            shopsRealmData.setValue(shop.maxCashback.value, forKey: "value")
            
            OperationQueue.main.addOperation {
                let realm = try! Realm()
                do{
                    try realm.write {
                        realm.add(shopsRealmData)
                    }
                } catch {
                    print("realm.write is not working")
                }
            }
        })
        
    }
    
    init(model: [ShopsModel]) {
        self.model = model
    }
    
    
}


enum ShopType{
    case selected
    case allShops
}

protocol ConfiguredShopsProtocol{
    func getShops(shopType: ShopType) ->[ShopDataRealm]
}


class ConfiguredShops: NSObject, ConfiguredShopsProtocol{
    
    var selectedShops: [ShopDataRealm]!
    var allShops: [ShopDataRealm]!
    func getShops(shopType: ShopType) ->[ShopDataRealm]{
        return configArray(shopType: shopType)
    }
    
    //fetching shops FromData
    private func configArray(shopType: ShopType) -> [ShopDataRealm]{
        
        
        
        switch shopType {
        case .selected:
            return selectedShops
        case .allShops:
            return allShops
        }
        
    }
    private func fetchData(){
        
            do{
                let realm = try Realm()
                let array = Array(realm.objects(ShopDataRealm.self))
                self.allShops = array
                array.forEach { (shop) in
                    if shop.isSelected{
                        self.selectedShops.append(shop)
                    }
                }
            } catch {
                print("Can't FETCH!!")
            }
        
    }
    override init() {
        super.init()
        fetchData()
    }
}

//Want to create a comlited array of shops
class ShopsDecorator{
    
    
}
struct DecoratedShops{
    var url: String
    var name: String
    var type: String
    var shopID: Int
    var pathImage: UIImage
    var categories:[Int]
    var currency: String
    var value: Double
    var isSelected: Bool
}
