//
//  OperationFilterController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/22/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class OperationFilterController: UIViewController {

    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "     ", with: .forceLeftToRight)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setClearNavigation(with: #colorLiteral(red: 0.0386101231, green: 0.8220543265, blue: 0.5023989081, alpha: 1), with: "Filter")
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.0386101231, green: 0.8220543265, blue: 0.5023989081, alpha: 1)
        navigationItem.title = "Filter"
        setTitleColor(with: .black)
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        
    }
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
      
    }
    @objc func handlePop(){
       navigationController?.popViewController(animated: true)
        
    }
   
}
