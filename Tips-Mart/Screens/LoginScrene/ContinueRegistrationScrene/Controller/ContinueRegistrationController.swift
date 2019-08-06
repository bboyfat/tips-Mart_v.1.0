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
    
    @IBOutlet var authView: AuthView!
    let animation = CustomBlurView()
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
    
    func addTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleEndEditing))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleEndEditing(){
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: .white, with: "")
        addTap()
    }
    
    func startAnimation(){
        animation.frame = self.view.bounds
        self.view.addSubview(animation)
        animation.startAnimation()
    }
    
    //MARK: IBActionStack
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkAuthCode(){
        guard let code = authCode() else {return}
        if authView.authTextField.text == String(code){
            model.authCode = code
            model.inviter = ""
            networkService.sendRequest(with: model) { (finish) in
                self.animation.stopAnim()
            }
            presentAgreement()
        } else {
            autWrongAlert()
        }
    }
    
    @IBAction func checkAuthBtn(_ sender: UIButton) {
        startAnimation()
        checkAuthCode()
    }
    // MARK: Methods
    

    func presentAgreement(){
        OperationQueue.main.addOperation {
            let vc = UIStoryboard(name: "ContinueRegistration", bundle: nil).instantiateViewController(withIdentifier: "AgreementVc") as! AgreementViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func autWrongAlert(){
        animation.stopAnim()
        let ac = UIAlertController(title: NSLocalizedString("warning", comment: ""), message: NSLocalizedString("doesntMatch", comment: ""), preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .cancel) { (_) in
            
        }
        ac.addAction(action)
        self.present(ac, animated: true, completion: nil)
    }

    
}
