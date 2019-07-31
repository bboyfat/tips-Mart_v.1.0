//
//  LoginValidator.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/31/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit


class LoginValidator{
    
    func checkPhoneNumber(_ phoneNumber: String) -> Bool{
        if phoneNumber.count >= 16{
            return true
        } else {
            return false
        }
    }
    
}

class LoginAnswerrErrors{
    func presentInfoController(controller: UIViewController){
        let ac = UIAlertController(title: nil, message: loginError, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(action)
        controller.present(ac, animated: true, completion: nil)
    }
}

