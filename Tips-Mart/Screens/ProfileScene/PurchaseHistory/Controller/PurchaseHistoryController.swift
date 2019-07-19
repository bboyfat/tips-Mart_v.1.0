//
//  PurchaseHistoryController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/17/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class PurchaseHistoryController: UIViewController {
    
    //MARK: Properties
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "", with: .forceLeftToRight)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "fillter"), with: "", with: .forceRightToLeft)
    
    @IBOutlet weak var tableView: UITableView!
    var tableDSD: PurchaseDSD!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableDSD = PurchaseDSD(tableView: tableView, controller: self)
        
        tableView.dataSource = tableDSD
        tableView.delegate = tableDSD
        
        addTargets()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: #colorLiteral(red: 0.0386101231, green: 0.8220543265, blue: 0.5023989081, alpha: 1), with: "")
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        addRightButtonToNavigationBar(with: setItemForNavigationBar(button: rightBarButton))
    }
   
    
    //MARK: Methods
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
        rightBarButton.addTarget(self, action: #selector(handlePush), for: .touchUpInside)
    }
    @objc func handlePop(){
         navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      navigationController?.popViewController(animated: true)
        
        
    }
    @objc func handlePush(){
        
    }
    
    
    
    
}
