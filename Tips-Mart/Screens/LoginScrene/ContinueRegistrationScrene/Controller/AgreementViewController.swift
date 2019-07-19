//
//  AgreementViewController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/3/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class AgreementViewController: UIViewController {
    
    
    //MARK: Properties
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow-2"), with: " Назад", with: .forceLeftToRight)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow-1"), with: " Принимаю ", with: .forceRightToLeft)
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
        setClearNavigation(with: .purple, with: "")
        addRightButtonToNavigationBar(with: setItemForNavigationBar(button: rightBarButton))
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
    }
    
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
        rightBarButton.addTarget(self, action: #selector(handlePush), for: .touchUpInside)
    }
    @objc func handlePop(){
        if navigationController != nil{
        navigationController?.popToRootViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    @objc func handlePush(){
        let vc = UIStoryboard(name: "ContinueRegistration", bundle: nil).instantiateViewController(withIdentifier: "FinishLoginVc") as! FinisRegistrationController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
