//
//  ShopsController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit



class ShopsController: UIViewController {
    
    var shopType: ShopType = .allShops{
        didSet{
            ccollectionViewDSDS.shopType = self.shopType
        }
    }
    
    var isTable = true{
        didSet{
            if self.isTable{
                ccollectionViewDSDS.collectionType = .table
            } else {
                ccollectionViewDSDS.collectionType = .collection
            }
        }
    }
    
    var selectedShops: [String] = []
    
    
    var networkRefreshProtocol: RefreshServiceProtocol!
    var collectionType: CollectionType = .table
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var ccollectionViewDSDS: ShopsDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkRefreshProtocol = MainShopsNetworkService()
        networkRefreshProtocol.sendRequest { (_) in
            SelectedShopsService().sendRequest(handler: { (selected) in
                self.selectedShops = selected
                self.ccollectionViewDSDS = ShopsDataSource(cv: self.collectionView, collectionType: self.collectionType, shopType: self.shopType, selectedList: self.selectedShops, viewController: self)
                self.collectionView.delegate = self.ccollectionViewDSDS
                self.collectionView.dataSource = self.ccollectionViewDSDS
            })
        }
        
    }
   
    @IBAction func segmentIndexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
           shopType = .allShops
        case 1:
           shopType = .selected
        default:
            break;
        }
    }
    
    
    
    
    
    @IBAction func switchCollectionType(_ sender: UIBarButtonItem) {
        isTable = !isTable
        if isTable{
            sender.image = #imageLiteral(resourceName: "shopsCollection")
        } else {
            sender.image = #imageLiteral(resourceName: "tableCollect")
        }
        
    }
    
    
    
    
}
