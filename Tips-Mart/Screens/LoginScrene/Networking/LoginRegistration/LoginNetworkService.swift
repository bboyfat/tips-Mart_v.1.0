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
    private var userOutput: UsersData?
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
                    print(data)
                    InitUserService().sendRequest(with: data, handler: { (_) in
                      
                    })
                    BalanceNetworkService().sendRequest(with: data, handler: { (_) in
                        
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
    
    private func saveSession(userData: UsersData){
//        userOutput = UsersData(userid: userData.userid, phoneNumber: userData.phoneNumber, name: userData.name, surname: userData.surname, createdTime: userData.createdTime, refreshToken: userData.refreshToken, accessToken: userData.accessToken, balance: userData.balance)
        
    }
    
    
    
}
