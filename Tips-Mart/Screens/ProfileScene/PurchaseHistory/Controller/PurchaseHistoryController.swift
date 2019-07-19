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
        setNavigation()
        
        tableDSD = PurchaseDSD(tableView: tableView, controller: self)
        
        tableView.dataSource = tableDSD
        tableView.delegate = tableDSD
        
        addTargets()
    }
   
    
    //MARK: Methods
    private func setNavigation(){
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1894809902, green: 0.7875444889, blue: 0.4261831641, alpha: 1)
        navigationItem.title = "История операций"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: setItems(button: rightBarButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: setItems(button: leftBarButton))
        navigationController?.navigationBar.isTranslucent = true
        
    }
    private func setItems(button: UIButton) -> UIView{
        let view = UIView()
        view.addSubview(button)
        view.frame = button.bounds
        return view
    }
    
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
