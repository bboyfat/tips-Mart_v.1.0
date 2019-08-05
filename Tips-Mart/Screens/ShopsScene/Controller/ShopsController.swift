//
//  ShopsController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

enum SenderForShops{
    case tabBar
    case search
}

class ShopsController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    //MARK: Properties
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "tableCollect"), with: "        ", with: .forceLeftToRight)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "done"), with: "      ", with: .forceRightToLeft)
    
    
    var customBlurAnimtion = CustomBlurView()
    var shopType: ShopType = .allShops{
        didSet{
            ccollectionViewDSDS.shopType = self.shopType
        }
    }
    var senderIs: SenderForShops = .tabBar
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
        setupAnimation()
        setNavigation()
        networkRefreshProtocol = MainShopsNetworkService()
        networkRefreshProtocol.sendRequest { (_) in
            SelectedShopsService().sendRequest(handler: { (selected) in
                self.selectedShops = selected
                self.setupDelegate()
            })
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
        addTargets()
        checkSender()
    }
    func setNavigation(){
        setClearNavigation(with: #colorLiteral(red: 0.0386101231, green: 0.8220543265, blue: 0.5023989081, alpha: 1), with: NSLocalizedString("Shops", comment: ""))
        setTitleColor(with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
       
    }
    func addRightButton(){
         addRightButtonToNavigationBar(with: setItemForNavigationBar(button: rightBarButton))
    }
    func addSwipe(){
//        let swipe = UISwipeGestureRecognizer()
//        swipe.direction = .down
//        swipe.addTarget(self, action: #selector(handleDismiss))
//        self.navBar.addGestureRecognizer(swipe)
    }
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
        rightBarButton.addTarget(self, action: #selector(handlePush), for: .touchUpInside)
    }
    @objc func handlePop(_ sender: UIButton){
        isTable = !isTable
        if isTable{
          sender.setImage(#imageLiteral(resourceName: "shopsCollection"), for: .normal)
        } else {
          sender.setImage(#imageLiteral(resourceName: "tableCollect"), for: .normal)
        }
        
        
    }
    @objc func handlePush(){
         self.dismiss(animated: true, completion: nil)
        
    }
    @objc func handleDismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    func checkSender(){
        switch senderIs {
        case .tabBar:
            self.view.endEditing(true)
        case .search:
            searchBar.becomeFirstResponder()
        }
    }
    private func setupDelegate(){
        self.ccollectionViewDSDS = ShopsDataSource(cv: self.collectionView, collectionType: self.collectionType, shopType: self.shopType, selectedList: self.selectedShops, viewController: self)
        self.collectionView.delegate = self.ccollectionViewDSDS
        self.collectionView.dataSource = self.ccollectionViewDSDS
        self.searchBar.delegate = self.ccollectionViewDSDS
        customBlurAnimtion.stopAnim()
    }
    private func setupAnimation(){
        customBlurAnimtion.frame = self.view.bounds
        self.view.addSubview(customBlurAnimtion)
        customBlurAnimtion.startAnimation()
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
