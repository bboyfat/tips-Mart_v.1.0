//
//  LogXib.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/3/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import SwiftPhoneNumberFormatter


class LogXib: UIView{
    let nibName = "LogXib"
    var contentVIew: UIView?
    let notificationCenter = NotificationCenter.default
    
    
    @IBOutlet weak var phoneNumber: PhoneFormattedTextField!
    
    @IBOutlet weak var loginBtnOutlet: UIButton!
    
    @IBOutlet weak var password: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setplaceHolders()
        phoneNumber.delegate = self
        postNotification()
        setPasswordView()
    }
    //set password rightView
    func setPasswordView(){
        password.addRightView()
        
    }
    
    //Post Notfication
    private func postNotification(){
        loginBtnOutlet.addTarget(self, action: #selector(handlePost), for: .touchUpInside)
    }
    @objc private func handlePost(){
        let userData: [String : Any] = ["phone": phoneNumber.text!, "pass": password.text!]
        notificationCenter.post(name: NSNotification.Name.loginPressed, object: self, userInfo: userData)
    }
    //Localized placeholders with white color
    private func setplaceHolders(){
        phoneNumber.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Enter phone number", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Enter password", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        guard let view = loadViewFromNib() else {return}
        view.frame = self.bounds
        self.addSubview(view)
        contentVIew = view
        
    }
    
    func loadViewFromNib() -> UIView?{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
        
    }
}

extension LogXib: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setMaskForPhone()
    }
    func setMaskForPhone(){
        phoneNumber.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: " (###) ###-##-##")
        phoneNumber.prefix = "+38"
    }
}
