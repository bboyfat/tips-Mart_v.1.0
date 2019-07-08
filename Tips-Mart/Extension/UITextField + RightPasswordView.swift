//
//  PasswordTextField.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/8/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

//Extension for password states, Simple to use and will save a lot of space
extension UITextField{
    
        static var isSecure = true
    
        func addRightView(){
            let passwordBtn: UIView = {
                let view = UIView()
                view.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                let button = UIButton()
                button.setImage(#imageLiteral(resourceName: "Group 5"), for: .normal)
                button.addTarget(self, action: #selector(didPressed), for: .touchUpInside)
                button.frame = view.bounds
                view.addSubview(button)
                return view
            }()
            rightViewMode = .always
            rightView = passwordBtn
        }
    
        @objc func didPressed(_ sender: UIButton){
    
            UITextField.isSecure = !UITextField.isSecure
            if UITextField.isSecure{
                isSecureTextEntry = true
                sender.setImage(#imageLiteral(resourceName: "Group 5"), for: .normal)
            } else {
                isSecureTextEntry = false
                sender.setImage(#imageLiteral(resourceName: "Group 6"), for: .normal)
            }
        }
    
}


