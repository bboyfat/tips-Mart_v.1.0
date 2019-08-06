//
//  PurchaseHistoryController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/17/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

enum PurchaseSender{
    case profile
    case more
}

class PurchaseHistoryController: UIViewController {
    
    var purchaseSender: PurchaseSender = .profile
    
    //MARK: Properties
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "       ", with: .forceLeftToRight)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "fillter"), with: "", with: .forceRightToLeft)
    
    @IBOutlet weak var tableView: UITableView!
    var tableDSD: PurchaseDSD!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PurchaseHistoryNetworking().sendRequest(with: PurchaseReqData(data: PurchaseReq())) { (model) in
            OperationQueue.main.addOperation {
                self.tableDSD = PurchaseDSD(tableView: self.tableView, controller: self, model: model)
                self.tableView.dataSource = self.tableDSD
                self.tableView.delegate = self.tableDSD
            }
          
        }
    
        
        
        
        
        addTargets()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: #colorLiteral(red: 0.0386101231, green: 0.8220543265, blue: 0.5023989081, alpha: 1), with: NSLocalizedString("Purchase history", comment:""))
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
//        addRightButtonToNavigationBar(with: setItemForNavigationBar(button: rightBarButton))
    }
   
    
    //MARK: Methods
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
        rightBarButton.addTarget(self, action: #selector(handlePush), for: .touchUpInside)
    }
    @objc func handlePop(){
         navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if purchaseSender == .profile{
      navigationController?.popViewController(animated: true)
        }  else {
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    @objc func handlePush(){
        
    }
    
    
    
    
}
