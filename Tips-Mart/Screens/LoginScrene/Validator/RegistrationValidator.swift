//
//  RegistrationValidator.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/31/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit


class RegistrationValidator{
    var viewCOntroller: UIViewController!
    func checkPassAndRepeatPass(_ password: String? = "", _ rePassword: String? = "") -> Bool{
        if password == rePassword && password != ""{
            return true
        } else {
            infoAlert(with: "Пароли не совпадают, проверьте правильность введенных данных и попробуйте еще раз")
            return false
        }
    }
    
    func checkPhoneNumber(_ phoneNumber: String? = "") -> Bool{
        if phoneNumber!.count >= 16{
            return true
        } else {
            infoAlert(with: "Введите пожалуйста номер в формате + 380 __ ___ __ __")
            return false
        }
    }
    func infoAlert(with massege: String){
        let ac = UIAlertController(title: nil, message: massege, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(action)
        viewCOntroller.present(ac, animated: true, completion: nil)
    }
    init(_ controller: UIViewController) {
        self.viewCOntroller = controller
    }
}
