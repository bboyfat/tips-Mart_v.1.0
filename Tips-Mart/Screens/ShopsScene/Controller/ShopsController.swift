//
//  ShopsController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

enum CollectionType{
    case table
    case collection
}

class ShopsController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var ccollectionViewDSDS: ShopsDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        ccollectionViewDSDS = ShopsDataSource(collectionView: collectionView)
        collectionView.dataSource = ccollectionViewDSDS
    }
    

   

}
