//
//  PreLoginController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/3/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class PreLoginController: UIViewController {
    //MARK: NSLayout Constraint
    @IBOutlet weak var activityBottomConastraint: NSLayoutConstraint!
    // Properties
    var networkService = RefreshToken()
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.modalTransitionStyle = .partialCurl
        self.modalPresentationStyle = .none
        animateView()
        
    }
    private func checkRefresh(){
        if refreshToken() != nil{
            networkService.sendRequest(with: TokenRefresh(token: refreshToken()!, userid: userId()!)) { (finish) in
                if finish{
                    self.presentTab()
                } else {
                    self.presentVc()
                }
            }
        } else {
            presentVc()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkRefresh()
    }

    // MARK: Methods
    private func presentTab(){
        OperationQueue.main.addOperation {
            let tabBarController = UIStoryboard(name: "MainTabBar", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBarController
            self.present(tabBarController, animated: true) { }
        }
    }
    private func presentVc(){
        OperationQueue.main.addOperation {
            let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVc") as! LoginController
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    private func animateView(){
        
        activityBottomConastraint.constant = 70
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
   
}
