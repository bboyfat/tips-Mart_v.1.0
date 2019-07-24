//
//  RegistrationViewModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit


class RegistrationViewModel: LoginViewModelProtocol{
    
    //    var networkProtocol: LoginNetworkService.loginModel
    var networkService = RegistrationNetworkService()
    
    var registrationModel: RegistrationModelRequset!
    
    // func ro send request for login
    func letsGo() {
        networkService.sendRequest(with: registrationModel) { (finish) in
        }
    }
    //private func to set data for registration
    private func fetch(registrationModel: RegistrationModelRequset){
        self.registrationModel = registrationModel
        
    }
    
    //init to be sure that model can't be a nil
    init(registrationModel: RegistrationModelRequset) {
        fetch(registrationModel: registrationModel)
    }
    
    
    
}
