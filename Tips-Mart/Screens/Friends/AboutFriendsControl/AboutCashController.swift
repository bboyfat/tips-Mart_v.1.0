//
//  AboutCashController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/18/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class AboutCashController: UIViewController {
    @IBOutlet weak var aboutEarnLbl: UILabel!
    //MARK: Properties
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: " Назад", with: .forceLeftToRight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addTargets()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        aboutEarnLbl.text = NSLocalizedString("aboutEarning", comment: "")
        setClearNavigation(with: #colorLiteral(red: 0.1894809902, green: 0.7875444889, blue: 0.4261831641, alpha: 1), with: NSLocalizedString("More Details", comment: ""))
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        setTitleColor(with: .black)
    }
    
    @IBAction func calculateBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "ShopWebView", bundle: nil).instantiateViewController(withIdentifier: "ShopWebViewVC") as! ShopWebViewController
        vc.url = "https://tips-mart.com/referrals"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
    }
    @objc func handlePop(){
        navigationController?.popViewController(animated: true)
        
    }

    
}
