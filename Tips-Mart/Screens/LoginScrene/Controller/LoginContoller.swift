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
    let notificationCenter = NotificationCenter.default
    //StatusBar style
    var loginModel = LoginModel()
    var viewModel: LoginViewModelProtocol!
    
    var regeistrModel: RegistrationModelRequset!
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
            self.regeistrModel = RegistrationModelRequset(options: OptionsForRegistration(inviter: "", phoneNumber: phoneNumber))
            self.viewModel = RegistrationViewModel(registrationModel: self.regeistrModel)
            self.viewModel.letsGo()
           
        }
        let vc =  UIStoryboard(name: "ContinueRegistration", bundle: nil).instantiateViewController(withIdentifier: "ContinueNavigation")
        present(vc, animated: true, completion: nil)
    }
    //OBserver for Login Btn Action
    private func addObserverForLoginBtn(){
        notificationCenter.addObserver(self, selector: #selector(handleLogin), name: NSNotification.Name.loginPressed, object: nil)
    }
    @objc private func handleLogin(_ notification: NSNotification){
        if let userInfo = notification.userInfo as NSDictionary?{
            self.loginModel.phoneNumber = userInfo["phone"] as? String
            self.loginModel.password = userInfo["pass"] as? String
            viewModel = LoginViewModel(loginModel: self.loginModel)
            viewModel.letsGo()
            let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBarController
            OperationQueue.main.addOperation {
                self.present(tabBarController, animated: true) {
                    
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
    
    
    private func setHidden(view: UIView){
        view.isHidden = true
    }
    
    
    deinit {
        notificationCenter.removeObserver(self)
    }
}



