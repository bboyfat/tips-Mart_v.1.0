//
//  LoginNetworkService.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import Alamofire


class LoginNetworkService: NetworkServiceProtocol{
    
    typealias loginModel = LoginModel
    private var dataBaseService: RealmServiceProtocol?
    private let userDefaults = UserDefaults.standard
    
    // with first request i will get a tokens
    func sendRequest(with params: LoginModel, handler: @escaping(_ status: Bool) ->()) {
        let data = try! JSONEncoder().encode(params)
        guard let params = try! JSONSerialization.jsonObject(with: data, options: []) as? Parameters else { handler(false); return }
       
        guard let url = URL(string: URLS.login.rawValue) else { handler(false); return}
        Alamofire.request(url, method: .post, parameters: params).response { (dataResponse) in
            if let data = dataResponse.data{
            do{
                let json = try JSONDecoder().decode(LoginToken.self, from: data)
                if let data = json.data{
                    // set values for tokens
                    self.userDefaults.set(data.accessToken.value, forKey: "accessToken")
                    self.userDefaults.set(data.refreshToken.value, forKey: "refreshToken")
                    //set expires for tokens
                    self.userDefaults.set(data.accessToken.expires, forKey: "accessExpires")
                    self.userDefaults.set(data.refreshToken.expires, forKey: "refreshExpires")
                    InitUserService().sendRequest(with: data, handler: { (_) in
                    })
        
                } else {
                    handler(false)
                }
                
                
            } catch {
                handler(false)
                }
        }
        }
    }
    
    
}
