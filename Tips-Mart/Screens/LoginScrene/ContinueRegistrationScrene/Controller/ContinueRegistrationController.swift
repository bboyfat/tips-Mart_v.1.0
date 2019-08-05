//
//  ContinueRegistrationController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/3/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ContinueRegistrationController: UIViewController {
    //MARK: Properties
    
   
    var model: SecondStepRegistration!
    var networkService = RegistrationSecondStep()
    
    //StatusBar style
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: .white, with: "")
    }
    
    //MARK: IBActionStack
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func checkAuthBtn(_ sender: UIButton) {
        guard let code = authCode() else {return}
        model.authCode = code
        model.inviter = ""
        networkService.sendRequest(with: model) { (finish) in
            
        }
        let vc = UIStoryboard(name: "ContinueRegistration", bundle: nil).instantiateViewController(withIdentifier: "AgreementVc") as! AgreementViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    // MARK: Methods
    

    
    

    
}
