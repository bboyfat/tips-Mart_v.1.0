//
//  RefreshToken.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//


import UIKit
import Alamofire

struct TokenRefresh: Codable{
    var token: String
    var userid: Int
    
}
//Second step of Login
//With this request you will get  User's Information such as: created;nickname;phoneNumber;userid ;
//You can use this reques aniwhere only if you have the access token
class InitUserService: RefreshServiceProtocol{
    
    private var dataBaseService: RealmServiceProtocol?
    
    //Second step of Login
    func sendRequest(handler: @escaping (Bool) -> ()) {
        
        guard let url = URL(string: URLS.userInit.rawValue) else { handler(false); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        guard let token = accessToken() else {return}
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let json = try JSONSerialization.jsonObject(with: response, options: [])
                    let answer  = try JSONDecoder().decode(UsersOutput.self, from: response)
                    guard let userData = answer.data else {return}
                    UserDefaults.standard.set(answer.data?.userid, forKey: "userId")
                    UserDefaults.standard.set(answer.data?.nickname, forKey: "nickname")
                    self.dataBaseService = RealmService(userData: userData)
                    self.dataBaseService?.save()
                    
                    print(json)
                    
                } catch let initErr{
                    print(initErr)
                }
            }
            
        }
    }
    
}




