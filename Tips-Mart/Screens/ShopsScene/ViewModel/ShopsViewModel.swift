//
//  ShopsViewModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import RxRealm
import RxSwift
import RealmSwift
protocol ShopViewModelProtocol {
    func itemsCount() -> Int
    func getShop(with indexPath: IndexPath) -> ShopDataRealm
    var dataUpdated: () -> () { get set }
    func searchShops(with text: String)
    
}

class ShopViewModel: ShopViewModelProtocol{
    
    var configeredShops: ObservableShopsProtocol!
    
    var shops: [ShopDataRealm] = []
    var selectedShopsList: [String] = []
    var selectedShops: [ShopDataRealm] = []
    var dataUpdated: () -> () = {}
    var bag = DisposeBag()
    func itemsCount() -> Int{
        return shops.count
    }
    func getShop(with indexPath: IndexPath) -> ShopDataRealm{
        return shops[indexPath.row]
    }
    
    func setShopsType(shopType: ShopType) {
        switch shopType {
        case .allShops:
            fetchModel(selectedShopsList: [])
        case .selected:
            shops.forEach({ (shop) in
                selectedShopsList.forEach({ (name) in
                    if shop.pathToShop == name{
                        selectedShops.append(shop)
                    } else {
                        print(shop.pathToShop, name)
                    }
                })
            })
            shops = selectedShops
        }
    }
    func searchShops(with text: String){
        let searchString = text
        let realm = try! Realm()
        let predicate = NSPredicate(format: "name contains[c] %@", searchString)
        let result = realm.objects(ShopDataRealm.self).filter(predicate)
        self.shops  = Array(result)
        self.dataUpdated()
        if shops.count == 0{
            fetchModel(selectedShopsList: selectedShopsList)
        }
    }
    func fetchModel(selectedShopsList: [String]){
        self.configeredShops = ObservableShops()
        self.selectedShopsList = selectedShopsList
        _ = self.configeredShops.getRealmModel { (result) in
            Observable.collection(from: result).subscribe(onNext: { [weak self] (arrayShops) in
                self?.shops = Array(arrayShops)
                self?.dataUpdated()
            }).disposed(by: bag)
        }
    }
    
    init(shopType: ShopType, selectedShopsList: [String]) {
        //getting data fram realm with config
        fetchModel(selectedShopsList: selectedShopsList)
        setShopsType(shopType: shopType)
        
    }
}

