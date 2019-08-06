//
//  WDView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/23/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import SwiftPhoneNumberFormatter

enum PhoneCard{
    case phone
    case card
}

class WDView: UIView {
    @IBOutlet weak var textFieldName: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var wdFieldWidth: NSLayoutConstraint!
    @IBOutlet weak var greenBalance: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    
    @IBOutlet weak var wdAmountlbl: UITextField!
    @IBOutlet weak var numberTextField: PhoneFormattedTextField!
    
    var switchPhoneCard: PhoneCard = .card{
        didSet{
            switch switchPhoneCard {
            case .phone:
                numberTextField.placeholder = "+38 (000) 000 00 00"
            case .card:
                numberTextField.placeholder = "1111-2222-3333-4444"
            }
        }
    }
    var isCard = false{
        didSet{
        }
    }
    
    var send: () -> () = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        currencyLbl.text = NSLocalizedString("uah", comment: "")
        setBorder()
        addTargets()
        numberTextField.delegate = self
        
    }
    private func addTargets(){
        phoneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhone)))
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCard)))
    }
    
    @objc func handlePhone(){
        isCard = false
        
        switchBorderColoe(isIt: isCard)
        
    }
    @objc func handleCard(){
        isCard = true
        switchBorderColoe(isIt: isCard)
    }
    func switchBorderColoe(isIt: Bool){
        switch isIt {
        case true:
            animateField()
            switchPhoneCard = .card
            textFieldName.text = "Enter card number"
            cardView.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.1098039216, blue: 0.6392156863, alpha: 1)
            phoneView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
            cardView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 1, alpha: 1)
            phoneView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case false:
            animateField()
            switchPhoneCard = .phone
            textFieldName.text = "Enter phone number"
            phoneView.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.1098039216, blue: 0.6392156863, alpha: 1)
            cardView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
            phoneView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 1, alpha: 1)
            cardView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    func animateField(){
        wdFieldWidth.constant = 214
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
    func setBorder(){
        phoneView.layer.borderWidth = 1
        cardView.layer.borderWidth = 1
        phoneView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        cardView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        
    }
    
    
}


extension WDView: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.count != 0{
        setMaskForPhone()
        }
    }
    func setMaskForPhone(){
        var formet = ""
        var prefix = ""
        switch switchPhoneCard{
        case .card:
            formet = "####-####-####-####"
            prefix = ""
        case .phone:
            formet = " (###) ###-##-##"
            prefix = "+38"
        }
        numberTextField.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: formet)
        numberTextField.prefix = prefix
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == wdAmountlbl{
        switch switchPhoneCard{
        case .phone:
            if let amount = textField.text {
                if let double = Double(amount){
                    if double < 5{
                        send()
                    }
                }
            }
        case .card:
            if let amount = textField.text {
                if let double = Double(amount){
                if double < 250.0{
                    send()
                }
                }
            }
        }
        }
    }
}
