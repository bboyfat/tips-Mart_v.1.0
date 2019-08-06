//
//  MoreController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/31/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import RealmSwift
class MoreController: UIViewController {
    @IBOutlet var moreView: MoreView!
    var viewModel: MainPageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        viewModel = MainPageViewModel()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presentControllers()
        setViews()
    }
    
    
    func setViews(){
        guard let nick = nickname() else { return}
        guard let id = userId() else {return}
        guard let greenBalance = greenBalance() else {return}
        guard let grayBalance = grayBalance() else {return}
        self.moreView.greenBalance.text = String(greenBalance)
        self.moreView.grayBalance.text = String(grayBalance) 
        self.moreView.idLabel.text = String(id).separate(every: 2, with: " ")
        self.moreView.nicknameLbl.text = nick
        
    }
    
    private func presentControllers(){
        moreView.profileDidTapped = {[weak self] in
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileController
            let nav = UINavigationController(rootViewController: vc)
            self?.present(nav, animated: true, completion: nil)
        }
        moreView.purchHistoryDidTapped = {[weak self] in
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "PurchaseVC") as! PurchaseHistoryController
            vc.purchaseSender = .more
            let nav = UINavigationController(rootViewController: vc)
            self?.present(nav, animated: true, completion: nil)
        }
        moreView.wdDidTapped = {[weak self] in
            let vc = UIStoryboard(name: "Withdrawal", bundle: nil).instantiateViewController(withIdentifier: "WDScreen") as! WDController
            let nav = UINavigationController(rootViewController: vc)
             self?.present(nav, animated: true, completion: nil)
        }
        moreView.bonusesDidTapped = {[weak self] in
            self?.tabBarController?.selectedViewController = self?.tabBarController?.viewControllers![2]
        }
        
        moreView.allShopsDidTapped = {[weak self] in
            self?.tabBarController?.selectedViewController = self?.tabBarController?.viewControllers![1]
        }
        moreView.selectedShopsDidTapped = {[weak self] in
            self?.tabBarController?.selectedViewController = self?.tabBarController?.viewControllers![1]
        }
        
        moreView.reviewDidTapped = {[weak self] in
            
        }
        moreView.logoutDidTapped = {[weak self] in
            UserDefaults.standard.set(nil, forKey: "refreshToken")
            UserDefaults.standard.set(nil, forKey: "accessToken")
            self?.tabBarController?.dismiss(animated: true, completion: nil
                
            )
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewModel = MainPageViewModel()
    }
    
    
}
