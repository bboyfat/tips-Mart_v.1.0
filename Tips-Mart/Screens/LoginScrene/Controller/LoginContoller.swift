//
//  ViewController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/3/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var enterBtnoutlet: UIButton!
    @IBOutlet weak var registrBtnOutlet: UIButton!
    
    @IBOutlet weak var loginUnderscore: UIView!
    @IBOutlet weak var regUnderscore: UIView!
    //MARK NSLayoutConsttaint
    @IBOutlet weak var regWidth: NSLayoutConstraint!
    //MARK: Properties
    
    var customBlurAnimtion = CustomBlurView()
    
    let notificationCenter = NotificationCenter.default
    var regValidator: RegistrationValidator!
     
    //StatusBar style
    var loginModel = LoginModel()
    var viewModel: LoginViewModelProtocol!
    
    var regeistrModel: RegistrationModelRequset!
    var secondStepReg: SecondStepRegistration!
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        regValidator = RegistrationValidator(self)
        enterBtnoutlet.setTitle(NSLocalizedString("Enter", comment: ""), for: .normal)
        addObserverForRegistrationBtn()
        addObserverForLoginBtn()
        addTap()
    }
    
    //Observer for Registration btnAction
    private func addObserverForRegistrationBtn(){
        notificationCenter.addObserver(self, selector: #selector(handleRegistration), name: NSNotification.Name.registrationPressed, object: nil)
    }
    @objc private func handleRegistration(_ notification: NSNotification){
        if let userInfo = notification.userInfo as NSDictionary?{
            guard let phoneNumber = userInfo["PhoneNumber"] as? String else {return}
            guard let password = userInfo["password"] as? String else {return}
            guard let rePassword = userInfo["rePassword"] as? String else {return}
            let result = phoneNumber.filter("+01234567890".contains)
            if self.regValidator.checkPassAndRepeatPass(password, rePassword) && self.regValidator.checkPhoneNumber(phoneNumber){
            self.regeistrModel = RegistrationModelRequset(phoneNumber: result )
                if password.count > 8{
                    self.secondStepReg = SecondStepRegistration(phoneNumber: result, authCode: 0, password: password, inviter: "", isMobileApp: true)
                    self.viewModel = RegistrationViewModel(registrationModel: self.regeistrModel)
                    self.viewModel.letsGo { (_) in
                        
                    }} else {
                    RegistrationValidator(self).passworMustBe()
                }
                }
            
           
        }
        let vc =  UIStoryboard(name: "ContinueRegistration", bundle: nil).instantiateViewController(withIdentifier: "AuthVc") as! ContinueRegistrationController
        let nav = UINavigationController.init(rootViewController: vc)
        vc.model = self.secondStepReg
        present(nav, animated: true, completion: nil)
    }
    //OBserver for Login Btn Action
    private func addObserverForLoginBtn(){
        notificationCenter.addObserver(self, selector: #selector(handleLogin), name: NSNotification.Name.loginPressed, object: nil)
    }
    @objc private func handleLogin(_ notification: NSNotification){
        self.setupAnimation()
        if let userInfo = notification.userInfo as NSDictionary?{
            self.loginModel.phoneNumber = userInfo["phone"] as? String
            self.loginModel.password = userInfo["pass"] as? String
            viewModel = LoginViewModel(loginModel: self.loginModel)
            viewModel.letsGo { (isSaved) in
                if isSaved{
                    self.presentMainTabBar()
                } else {
                    self.customBlurAnimtion.stopAnim()
                    LoginAnswerrErrors().presentInfoController(controller: self)
                }
            }
           
        }
    }
    // Gesture for end editing
    func addTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tap)
    }
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    
    
    //MARK: IBActions stack
    // btn to chose login
    @IBAction func choseLoginBtn(_ sender: UIButton) {
        setHidden(view: regUnderscore)
        loginUnderscore.isHidden = false
        enterBtnoutlet.setTitleColor(.white, for: .normal)
        registrBtnOutlet.setTitleColor(.unHighlitedBtn, for: .normal)
        regWidth.constant = 0
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    //btn to chose registration
    @IBAction func choseRegBtn(_ sender: UIButton) {
        setHidden(view: loginUnderscore)
        regUnderscore.isHidden = false
        registrBtnOutlet.setTitleColor(UIColor.white, for: .normal)
        
        enterBtnoutlet.setTitleColor(.unHighlitedBtn, for: .normal)
    
        regWidth.constant = self.view.frame.width
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    //Present MAIN TAB BAR
    func presentMainTabBar(){
        OperationQueue.main.addOperation {
            let tabBarController = UIStoryboard(name: "MainTabBar", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBarController
            
            self.present(tabBarController, animated: true) {
                self.customBlurAnimtion.stopAnim()
            }
        }
    }
    private func setupAnimation(){
        customBlurAnimtion.frame = self.view.bounds
        self.view.addSubview(customBlurAnimtion)
        customBlurAnimtion.startAnimation()
    }
    
    private func setHidden(view: UIView){
        view.isHidden = true
    }
    
    
    deinit {
        notificationCenter.removeObserver(self)
    }
}



