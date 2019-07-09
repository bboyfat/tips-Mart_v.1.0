//
//  RegXib.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/3/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import SwiftPhoneNumberFormatter


class RegXib: UIView{
    //MARK: Outlets
    @IBOutlet weak var phoneNumber: PhoneFormattedTextField!
    
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registrationBtn: UIButton!
    //MARK: Properties
    let nibName = "RegXib"
    var contentVIew: UIView?
    let notificationCenter = NotificationCenter.default
    //MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setplaceHolders()
        phoneNumber.delegate = self
        postNotification()
        setPasswordsViews()
        
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
    }
    //passwords views for textFields
    func setPasswordsViews(){
        password.addRightView()
        repeatPassword.addRightView()
    }
    //Localized placeholders with white color
    private func setplaceHolders(){
        phoneNumber.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Enter phone number", comment: "") , attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Enter password", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        repeatPassword.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Repeat password", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    //Post Notfication
    private func postNotification(){
        registrationBtn.addTarget(self, action: #selector(handlePost), for: .touchUpInside)
    }
    @objc private func handlePost(){
        let userInfo: [String : Any] = ["PhoneNumber": phoneNumber.text!, "password": password.text!]
        
        notificationCenter.post(name: NSNotification.Name.registrationPressed, object: self, userInfo: userInfo)
    }
    
    
    //MARK: Initialization
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
extension RegXib: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setMaskForPhone()
    }
    func setMaskForPhone(){
        phoneNumber.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: " ### ### ## ##")
        phoneNumber.prefix = "+38"
    }
}



