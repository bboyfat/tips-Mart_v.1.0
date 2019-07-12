//
//  ShopsDSD.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
///Users/andreypetrovskiy/Desktop/Tips-Mart.v.1.0/Tips-Mart/Tips-Mart/Screens/LoginScrene/Networking/RefreshData/RefreshTokenService.swift

import UIKit

enum CollectionType{
    case table
    case collection
}

class ShopsDataSource: NSObject, UICollectionViewDataSource{
    
    var viewModel: ShopViewModelProtocol!{
        didSet{
            collectionView.reloadData()
        }
    }
    
    var collectionView: UICollectionView!
    
    var collectionType: CollectionType = .table{
        didSet{
            let indexPath = collectionView.indexPathsForVisibleItems
            collectionView.reloadItems(at: indexPath)
           
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        switch collectionType {
        case .table:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tableShopCell", for: indexPath) as! TableShopCell
        case .collection:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectShopcCell", for: indexPath) as! ShopCollectionCell
        }
        setCell(someCell: cell as! ShopsCellProtocol, with: indexPath)
        return cell
    }
    
    private func setCell(someCell: ShopsCellProtocol, with indexPath: IndexPath) {
        let shop = viewModel.getShop(with: indexPath)
        someCell.shopName.text = shop.name
        someCell.cashbackValue.text = String(shop.value)
        someCell.cashbackCurrency.text = shop.currency
        
        LogoNetworkService().getImages(with: shop.pathImage) { (image) in
            OperationQueue.main.addOperation {
                someCell.logoImage.image = image
            }
        }
    }
    init(collectionView: UICollectionView, collectionType: CollectionType, shopType: ShopType) {
        viewModel = ShopViewModel(shopType: shopType)
        self.collectionView = collectionView
        self.collectionType = collectionType
        let nibTable = UINib(nibName: "TableShopCell", bundle: nil)
        collectionView.register(nibTable, forCellWithReuseIdentifier: "tableShopCell")
        let nibCollect = UINib(nibName: "ShopCollectionCell", bundle: nil)
        collectionView.register(nibCollect, forCellWithReuseIdentifier: "collectShopcCell")
        
        
    }
    deinit {
        self.collectionView.reloadData()
    }
}


extension ShopsDataSource: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.width / 2 - 15
        let collectionSize = CGSize(width: width, height: width)
        let tableSize = CGSize(width: self.collectionView.frame.width, height: 110)
        switch collectionType {
        case .table:
            return tableSize
        case .collection:
            return collectionSize
        }
    }
    
}
extension ShopsDataSource: UICollectionViewDelegate{
    
}
