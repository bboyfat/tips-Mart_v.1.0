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
 //Secons step of Login
class InitUserService: NetworkServiceProtocol{
    
    typealias loginModel = Tokens
    
    //Secons step of Login
    func sendRequest(with params: Tokens, handler: @escaping (Bool) -> ()) {
        
        guard let url = URL(string: URLS.userInit.rawValue) else { handler(false); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        urlRequest.addValue("Bearer \(params.accessToken.value)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode(UsersOutput.self, from: response)
                    
                    
                    
                    print(answer)
                    
                } catch{
                    print(Error.self)
                }
            }
        }
    }
    
}




