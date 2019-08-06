//
//  PreLoginController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/3/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import Reachability

class PreLoginController: UIViewController {
    //MARK: NSLayout Constraint
    @IBOutlet weak var activityBottomConastraint: NSLayoutConstraint!
    // Properties
    var reachability: Reachability!
    var networkService = RefreshToken()
    let appDelegate = AppDelegate()
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.modalPresentationStyle = .none
        animateView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reachability = Reachability()!
        startNotifyReachability()
    }

    // MARK: Methods
    func startNotifyReachability(){
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do{
            try reachability!.startNotifier()
        } catch {
            print("could not start notifier")
        }
        
    }
    
    @objc func internetChanged(note: Notification){
        let reachability = note.object as! Reachability
        if reachability.connection != .none{
            checkRefreshWithConnection()
        } else {
            checkRefreshWithoutConnection()
        }
        
    }
    private func checkRefreshWithConnection(){
        
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
    private func checkRefreshWithoutConnection(){
        
        if refreshToken() != nil{
           InternetAlert().tokenisNotEmpytAlert(controller: self)
        } else {
           InternetAlert().tokenisEmpytAlert(controller: self)
          
        }
    }
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
