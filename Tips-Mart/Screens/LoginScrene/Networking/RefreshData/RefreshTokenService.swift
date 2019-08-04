//
//  RefreshTokenService.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import Alamofire

class RefreshToken: NetworkServiceProtocol{
    
    typealias loginModel = TokenRefresh
    let userDefaults = UserDefaults.standard
    func sendRequest(with params: TokenRefresh, handler: @escaping (Bool) -> ()) {
        let data = try! JSONEncoder().encode(params)
        guard let params = try! JSONSerialization.jsonObject(with: data, options: []) as? Parameters else { handler(false); return }
        guard let url = URL(string: URLS.refreshToken.rawValue) else { handler(false); return}
        Alamofire.request(url, method: .put, parameters: params).response { (dataResponse) in
            if let data = dataResponse.data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let answer = try JSONDecoder().decode(LoginToken.self, from: data)
                    // set values for tokens
                    self.userDefaults.set(answer.data?.accessToken.value, forKey: "accessToken")
                    self.userDefaults.set(answer.data?.refreshToken.value, forKey: "refreshToken")
//                    //set expires for tokens
                    self.userDefaults.set(answer.data?.accessToken.expires, forKey: "accessExpires")
                    self.userDefaults.set(answer.data?.refreshToken.expires, forKey: "refreshExpires")
                    handler(true)
                } catch {
                    handler(false)
                }
            }
        }
        
    }
    
}
