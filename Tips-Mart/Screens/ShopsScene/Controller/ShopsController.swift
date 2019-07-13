//
//  ShopsController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit



class ShopsController: UIViewController {
    
    var isTable = true{
        didSet{
            if self.isTable{
                ccollectionViewDSDS.collectionType = .table
            } else {
                ccollectionViewDSDS.collectionType = .collection
            }
        }
    }
    var networkRefreshProtocol: RefreshServiceProtocol!
    var collectionType: CollectionType = .table
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var ccollectionViewDSDS: ShopsDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ccollectionViewDSDS = ShopsDataSource(cv: self.collectionView, collectionType: self.collectionType, shopType: .allShops)
        self.collectionView.delegate = self.ccollectionViewDSDS
        self.collectionView.dataSource = self.ccollectionViewDSDS
        networkRefreshProtocol = MainShopsNetworkService()
        networkRefreshProtocol.sendRequest { (finished) in

        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
