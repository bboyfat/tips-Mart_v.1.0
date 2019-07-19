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
    
    var viewModel: ShopViewModelProtocol!
    var viewController: UIViewController!
    var collectionView: UICollectionView!
    
    var selectedList: [String] = []
    
    var shopType: ShopType = .allShops{
        didSet{
            viewModel = ShopViewModel(shopType: shopType, selectedShopsList: selectedList)
            collectionView.reloadData()
        }
    }
    
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
    func setViewModel(){
        viewModel.dataUpdated = {[weak self] in
            self?.collectionView.reloadData()
            
        }
    }
    init(cv: UICollectionView, collectionType: CollectionType, shopType: ShopType, selectedList: [String], viewController: UIViewController) {
        self.selectedList = selectedList
        self.viewController = viewController
        viewModel = ShopViewModel(shopType: shopType, selectedShopsList: self.selectedList)
        viewModel.dataUpdated = {[weak cv] in
            cv?.reloadData()
            
        }
        self.collectionView = cv
        self.collectionType = collectionType
        let nibTable = UINib(nibName: "TableShopCell", bundle: nil)
        cv.register(nibTable, forCellWithReuseIdentifier: "tableShopCell")
        let nibCollect = UINib(nibName: "ShopCollectionCell", bundle: nil)
        cv.register(nibCollect, forCellWithReuseIdentifier: "collectShopcCell")
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let shop =  viewModel.getShop(with: indexPath)
        let detailShopController = UIStoryboard(name: "OneShop", bundle: nil).instantiateViewController(withIdentifier: "DetailShop") as! DetailShopController
          detailShopController.shopData = shop
           detailShopController.pathToShop = shop.pathToShop
        let navController = UINavigationController(rootViewController: detailShopController)
      
        viewController.present(navController, animated: true, completion: nil)
        
        print(indexPath)
    }
}
