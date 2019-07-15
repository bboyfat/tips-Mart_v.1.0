//
//  ShopsDataBaseService.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/10/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import RealmSwift
import RxRealm
protocol ShopsDataBaseProtocol {
    func ifHasChanges()
}

class ShopsDataBaseService: ShopsDataBaseProtocol{
    let notificationCenter = NotificationCenter.default
    var model: [ShopsModel]!
    //Saving shops to realm
    var shopData: [ShopDataRealm] = []
    
    func madeAnArray(){
        model.forEach({ (shop) in
            let shopsRealmData = ShopDataRealm()
            shopsRealmData.setValue(shop.pathToShop, forKey: "url")
            shopsRealmData.setValue(shop.type, forKey: "type")
            shopsRealmData.setValue(shop.shopID, forKey: "shopID")
            shopsRealmData.setValue(shop.pathToImage, forKey: "pathImage")
            shopsRealmData.setValue(shop.name, forKey: "name")
            shopsRealmData.setValue(shop.categories, forKey: "categories")
            shopsRealmData.setValue(shop.pathToShop, forKey: "pathToShop")
            shopsRealmData.setValue(shop.maxCashback.typeCurrency, forKey: "currency")
            shopsRealmData.setValue(shop.maxCashback.value, forKey: "value")
            shopData.append(shopsRealmData)
        })
        
    }
    func saveShopsToData(){
        
        do{
            let realm = try Realm()
            try realm.write {
                realm.add(shopData, update: .error)
            }
            
        } catch {
            print("realm.write is not working")
        }
        
        
    }
    
    func ifHasChanges(){
        do{
            let realm = try Realm()
            let result = Array(realm.objects(ShopDataRealm.self))
            if result.isEmpty{
                self.saveShopsToData()
            } else if result != shopData{
                self.updateData()
            }
        } catch {
            print(ifHasChanges)
        }
        
    }
    
    func updateData(){
        clearData()
        saveShopsToData()
    }
    
    func clearData(){
        do{
            let realm = try Realm()
            let results = realm.objects(ShopDataRealm.self)
            try realm.write {
                realm.delete(results)
            }
        } catch{
            print("Delete all")
        }
    }
    
    
    
    
    init(model: [ShopsModel]) {
        self.model = model
        madeAnArray()
    }
    
    
}


enum ShopType{
    case selected
    case allShops
}

protocol ObservableShopsProtocol{
    
    func getRealmModel(handler: (Results<ShopDataRealm>)->())
}


class ObservableShops: NSObject, ObservableShopsProtocol{
    
    func getRealmModel(handler: (Results<ShopDataRealm>)->()){
        
        do{
            let realm = try Realm()
            handler(realm.objects(ShopDataRealm.self))
        } catch{
            print(getRealmModel)
        }
        
    }
    
    override init() {
        super.init()
        
    }
}

