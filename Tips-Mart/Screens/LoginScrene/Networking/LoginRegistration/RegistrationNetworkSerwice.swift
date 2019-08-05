//
//  RegistrationNetworkSerwice.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import Alamofire

class RegistrationNetworkService: NetworkServiceProtocol{
    
    
    typealias loginModel = RegistrationModelRequset
   
    
    func sendRequest(with params: RegistrationModelRequset, handler: @escaping(_ status: Bool) ->()) {
        let data = try! JSONEncoder().encode(params)
        guard let params = try! JSONSerialization.jsonObject(with: data, options: []) as? Parameters else { handler(false); return }
        guard let url = URL(string: URLS.authURL.rawValue) else { handler(false); return}
        Alamofire.request(url, method: .post, parameters: params).response { (dataResponse) in
            if let data = dataResponse.data{
                do{
                    let json = try JSONDecoder().decode(AuthOutput.self, from: data)
                    UserDefaults.standard.set(json.code, forKey: "authCode")
                    print(json)
                    handler(true)
                } catch let regErr{
                    handler(false)
                    print(regErr)
                }
            }
        }
    }
}


class RegistrationSecondStep: NetworkServiceProtocol {
    let userDefaults = UserDefaults.standard
    typealias loginModel = SecondStepRegistration
    // here i need: phone number, password, authCode
    
    func sendRequest(with params: SecondStepRegistration, handler: @escaping (Bool) -> ()) {
        let data = try! JSONEncoder().encode(params)
        guard let params = try! JSONSerialization.jsonObject(with: data, options: []) as? Parameters else { handler(false); return }
        guard let url = URL(string: URLS.regURL.rawValue) else { handler(false); return}
        Alamofire.request(url, method: .post, parameters: params).response { (dataResponse) in
            if let data = dataResponse.data{
                do{
                    let json = try JSONDecoder().decode(TokkensAfterRegistration.self, from: data)
                    print(json)
                   
                    // set values for tokens
                    self.userDefaults.set(json.data.accessToken.value, forKey: "accessToken")
                    self.userDefaults.set(json.data.refreshToken.value, forKey: "refreshToken")
                    //set expires for tokens
                    self.userDefaults.set(json.data.accessToken.expires, forKey: "accessExpires")
                    self.userDefaults.set(json.data.refreshToken.expires, forKey: "refreshExpires")
                } catch let err {
                    print(err)
                    handler(false)
                }
            }
        }
    }
}

