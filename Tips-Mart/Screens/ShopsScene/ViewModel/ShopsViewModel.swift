//
//  ShopsViewModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit


protocol ShopViewModelProtocol {
    func itemsCount() -> Int
    func getShop(with indexPath: IndexPath) -> ShopDataRealm
}

class ShopViewModel: ShopViewModelProtocol{
    
    var configeredShops: ConfiguredShopsProtocol!
    var shops: [ShopDataRealm]
    func itemsCount() -> Int{
        return shops.count
    }
    func getShop(with indexPath: IndexPath) -> ShopDataRealm{
        return shops[indexPath.row]
    }
    
    init(shopType: ShopType) {
      
        self.configeredShops = ConfiguredShops()
        self.shops =  self.configeredShops.getShops(shopType: shopType)
    }
}

