//
//  DetailShopController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/12/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class DetailShopController: UIViewController {
    var dataSourceDelegate: ReviewDSD!
    var model: Shop!
    var shopData: ShopDataRealm!
    var pathToShop: String = ""
    @IBOutlet var shopView: DetailShopView!
    @IBOutlet weak var reviewTableView: UITableView!
    //MARK: Properties
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow-2"), with: " Назад", with: .forceLeftToRight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: setItems(button: leftBarButton))
        dataSourceDelegate = ReviewDSD(tableView: reviewTableView)
        reviewTableView.dataSource = dataSourceDelegate
        reviewTableView.delegate = dataSourceDelegate
        ShopNetworkService(pathToshop: pathToShop).sendRequest { (shop) in
            self.model = shop
            
        }
        self.setLabels()
    }
    
    private func setItems(button: UIButton) -> UIView{
        let view = UIView()
        view.addSubview(button)
        view.frame = button.bounds
        return view
    }
   
    func setLabels(){
        shopView.cashbackCurrencyLbl.text = shopData.currency
        shopView.cashBackValueLbl.text = String(shopData.value)
    }

    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
    }
    @objc func handlePop(){
        if navigationController != nil{
            navigationController?.popToRootViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
