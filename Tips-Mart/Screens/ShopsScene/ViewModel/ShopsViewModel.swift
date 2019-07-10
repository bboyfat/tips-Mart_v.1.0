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
    func getLogo(with path: String) -> UIImage
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
    
    func getLogo(with path: String) -> UIImage{
        var imageLogo: UIImage!
        LogoNetworkService().getImages(with: path) { (image) in
            imageLogo = image ?? UIImage()
        }
        return imageLogo
    }
        
    
    
    
    init(shopType: ShopType) {
        configeredShops = ConfiguredShops()
        self.shops =  configeredShops.getShops(shopType: shopType)
    }
}

