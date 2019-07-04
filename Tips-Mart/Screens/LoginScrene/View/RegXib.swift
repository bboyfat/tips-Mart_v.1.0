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
     #warning("Don't Forget to create password textField")
    var isAgreed = false
    let notificationCenter = NotificationCenter.default
     #warning("Don't Forget to create password textField")
    let rightButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Group 5"), with: "", with: .unspecified)
    let rightBtn2 = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Group 5"), with: "", with: .unspecified)
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setplaceHolders()
        phoneNumber.delegate = self
        postNotification()
        password.rightView = setItems(button: rightButton)
        repeatPassword.rightView = setItems(button: rightBtn2)
        password.rightViewMode = .always
        repeatPassword.rightViewMode = .always
        
    }
    //MARK: Methods
    private func setItems(button: UIButton) -> UIView{
         #warning("Don't Forget to create password textField")
        rightButton.addTarget(self, action: #selector(handleAgree), for: .touchUpInside)
        let view = UIView()
        view.frame = CGRect(x: -20, y: 0, width: 30, height: 30)
        view.tintColor = .white
        view.addSubview(button)
        button.frame = view.bounds
        
        return view
    }
    #warning("Don't Forget to create password textField")
    @objc func handleAgree(){
        isAgreed = !isAgreed
        checkPass()
    }
     #warning("Don't Forget to create password textField")
    func checkPass(){
        if isAgreed {
            rightButton.setImage(#imageLiteral(resourceName: "Group 6"), for: .normal)
            password.isSecureTextEntry = false
        } else {
            rightButton.setImage(#imageLiteral(resourceName: "Group 5"), for: .normal)
            password.isSecureTextEntry = true
        }
    }
    private func setplaceHolders(){
        phoneNumber.attributedPlaceholder = NSAttributedString(string: "Введите свой номер телефона", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.attributedPlaceholder = NSAttributedString(string: "Введите пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        repeatPassword.attributedPlaceholder = NSAttributedString(string: "Введите пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    //Post Notfication
    private func postNotification(){
        registrationBtn.addTarget(self, action: #selector(handlePost), for: .touchUpInside)
    }
    @objc private func handlePost(){
        notificationCenter.post(name: NSNotification.Name.registrationPressed, object: self)
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
        phoneNumber.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: " (###) ###-##-##")
        phoneNumber.prefix = "+38"
    }
}



