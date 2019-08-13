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
    func searchShops(with latinKiriill: [String])
    
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
    func searchShops(with text: [String]){
        let realm = try! Realm()
        guard let latinString = text.first, let cirillString = text.last else {return}
        let latinPredicate = NSPredicate(format: "name contains[c] %@", latinString)
        let latinResult = realm.objects(ShopDataRealm.self).filter(latinPredicate)
        let cirillPredicate = NSPredicate(format: "name contains[c] %@", cirillString)
        let cirillResult = realm.objects(ShopDataRealm.self).filter(cirillPredicate)
        self.shops  = Array(latinResult) + Array(cirillResult)
        self.dataUpdated()
        if latinString.isEmpty{
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

