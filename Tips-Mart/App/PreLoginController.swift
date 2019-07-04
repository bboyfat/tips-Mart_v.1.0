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
    let userDefaults = UserDefaults.standard
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        animateView()
     
        if userDefaults.bool(forKey: "isFirstLogin"){
          presentVc()
        } else {
          presentVc()
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    // MARK: Methods
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
