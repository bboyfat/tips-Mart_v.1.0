//
//  ProfileController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    //MARK: Properties
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "", with: .forceLeftToRight)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Icon"), with: "", with: .forceRightToLeft)
    //StatusBar style
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets() // add targets fot items
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: .white, with: "")
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
         self.dismiss(animated: true, completion: nil)
      
        
    }
    @objc func handlePush(){
      
    }
    //MARK: IBAction
    @IBAction func presentPurchaseHistory(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PurchaseVC") as! PurchaseHistoryController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    

}
