//
//  AgreementViewController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/3/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import WebKit

class AgreementViewController: UIViewController {
    
    
    //MARK: Properties
    @IBOutlet var webVIew: WKWebView!
    
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow-2"), with: " Назад", with: .forceLeftToRight)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow-1"), with: " Принимаю ", with: .forceRightToLeft)
    //StatusBar style
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    var url: String?
    
    
    
    
    
    
    
    func loadUrl(stringUrl: String){
        guard  let url = URL(string: stringUrl) else {
            return
        }
        let urlReq = URLRequest(url: url)
        webVIew.load(urlReq)
    }
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets() // add targets fot items
        if let url = url{
            loadUrl(stringUrl: url)
        }
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
