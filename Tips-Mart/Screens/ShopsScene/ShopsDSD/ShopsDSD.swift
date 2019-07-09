//
//  ShopsDSD.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ShopsDataSource: NSObject, UICollectionViewDataSource{
    
    var viewModel: Any!
    var collectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let nib = UINib(nibName: "TableShopCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "tableShopCell")
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tableShopCell", for: indexPath)
        return cell
    }
    init(collectionView: UICollectionView) {
        
        self.collectionView = collectionView
        
        
    }
    
}


extension ShopsDataSource: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 100)
    }
    
}
extension ShopsDataSource: UICollectionViewDelegate{
    
}
