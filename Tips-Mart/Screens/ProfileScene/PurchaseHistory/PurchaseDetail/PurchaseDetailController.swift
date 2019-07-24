//
//  PurchaseDetailController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/17/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class PurchaseDetailController: UIViewController {
    
    //MARK: Properties
    var model: PurchaseObject!
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: " Назад", with: .forceLeftToRight)
    
    @IBOutlet var purchaseDetailView: PurchaseDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        if model != nil{
            setLabels(model: model)
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: #colorLiteral(red: 0.0386101231, green: 0.8220543265, blue: 0.5023989081, alpha: 1), with: "Детали")
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        
    }
    
    
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
    }
    @objc func handlePop(){
        navigationController?.popViewController(animated: true)
    }
    
    private func setLabels(model: PurchaseObject){
        purchaseDetailView.operationID.text = model.cashbackID
        purchaseDetailView.operationState.text = ""
        purchaseDetailView.shopNameLbl.text = model.shopData.name
        purchaseDetailView.sumPurchaseLbl.text = String(model.sumPurchase)
        purchaseDetailView.cashbackSum.text = String(model.userCashback)
        purchaseDetailView.createdLbl.text = model.created
        purchaseDetailView.updatedLbl.text = model.updated
    }
   
    
}
