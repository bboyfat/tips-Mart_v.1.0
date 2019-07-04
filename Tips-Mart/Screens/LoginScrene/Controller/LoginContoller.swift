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
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserverForRegistrationBtn()
        addTap()
    }
    private func addObserverForRegistrationBtn(){
        notificationCenter.addObserver(self, selector: #selector(handleObserve), name: NSNotification.Name.registrationPressed, object: nil)
    }
    @objc private func handleObserve(){
        let vc =  UIStoryboard(name: "ContinueRegistration", bundle: nil).instantiateViewController(withIdentifier: "ContinueNavigation")
        present(vc, animated: true, completion: nil)
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

