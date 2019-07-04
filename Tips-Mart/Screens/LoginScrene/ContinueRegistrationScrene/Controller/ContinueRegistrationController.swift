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
    
    
    
    //StatusBar style
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setPlaceHolder()
        setNavigation()
    }
    
    
    //MARK: IBActionStack
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func checkAuthBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "ContinueRegistration", bundle: nil).instantiateViewController(withIdentifier: "AgreementVc") as! AgreementViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    // MARK: Methods
    
    private func setNavigation(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    
    //MARK: View Settings
//    private func setPlaceHolder(){
//        authTextField.attributedPlaceholder = NSAttributedString(string: "Код", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
//    }
    
}
