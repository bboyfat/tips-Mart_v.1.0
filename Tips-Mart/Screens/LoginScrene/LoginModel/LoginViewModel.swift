//
//  LoginViewModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

enum LoginSuccess{
    case succes
    case failed
}

protocol LoginViewModelProtocol{
    func letsGo()
}

class LoginViewModel: LoginViewModelProtocol{
    
//    var networkProtocol: LoginNetworkService.loginModel
    var networkService = LoginNetworkService()
    var loginModel: LoginModel!
    // func ro send request for login
    func letsGo() {
        networkService.sendRequest(with: loginModel) { (finish) in
            if finish{
                print(self.loginModel as Any)
            }
        }
    }
    //private func to set data for login
    private func fetch(loginModel: LoginModel){
        self.loginModel = loginModel
    }
    
    //init to be sure that model can't be a nil
    init(loginModel: LoginModel) {
        fetch(loginModel: loginModel)
    }
    
    
    
}

