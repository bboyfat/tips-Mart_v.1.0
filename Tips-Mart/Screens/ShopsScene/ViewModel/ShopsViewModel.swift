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

protocol ShopViewModelProtocol {
    func itemsCount() -> Int
    func getShop(with indexPath: IndexPath) -> ShopDataRealm
    var dataUpdated: () -> () { get set }

}

class ShopViewModel: ShopViewModelProtocol{
    
    var configeredShops: ConfiguredShopsProtocol!
    
    var shops: [ShopDataRealm] = []
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
            shops.sort{$0.name < $1.name}
        case .selected:
            shops.filter({ (shops) -> Bool in
                shops.isSelected == true
            })
        }
        
    }
    
    init(shopType: ShopType) {
      //getting data fram realm with config
        self.configeredShops = ConfiguredShops()
//        self.shops =  self.configeredShops.getShops(shopType: shopType)
        _ = self.configeredShops.getRealmModel { (result) in
            Observable.collection(from: result).subscribe(onNext: { [weak self] (arrayShops) in
                    self?.shops = Array(arrayShops)
                self?.dataUpdated()
                }).disposed(by: bag)
        }
        
    }
}

