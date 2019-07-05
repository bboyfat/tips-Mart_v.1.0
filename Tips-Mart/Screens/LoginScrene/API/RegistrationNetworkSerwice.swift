//
//  RegistrationNetworkSerwice.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import Alamofire

#warning("Think about structure of registration request")

class RegistrationNetworkService: NetworkServiceProtocol{
    
    
    typealias loginModel = RegistrationModelRequset
    // i need phone number here
    var dataType: Any?
    
    func sendRequest(with params: RegistrationModelRequset, handler: @escaping(_ status: Bool) ->()) {
        let data = try! JSONEncoder().encode(params)
        guard let params = try! JSONSerialization.jsonObject(with: data, options: []) as? Parameters else { handler(false); return }
        guard let url = URL(string: URLS.authURL.rawValue) else { handler(false); return}
        Alamofire.request(url, method: .post, parameters: params).response { (dataResponse) in
            if let data = dataResponse.data{
                do{
                    let json = try JSONDecoder().decode(AuthOutput.self, from: data)
                    self.dataType = json
                } catch {
                    handler(false)
                }
            }
        }
    }
    func getAuthCode() -> Int{
        if let data = dataType as? AuthOutput{
            return data.code
        }
        return 0
    }
   
}



class RegistrationSecondStep: NetworkServiceProtocol {
    
    
    typealias loginModel = SecondStepRegistration
    // here i need: phone number, password, authCode
    
    func sendRequest(with params: SecondStepRegistration, handler: @escaping (Bool) -> ()) {
        let data = try! JSONEncoder().encode(params)
        guard let params = try! JSONSerialization.jsonObject(with: data, options: []) as? Parameters else { handler(false); return }
        guard let url = URL(string: URLS.authURL.rawValue) else { handler(false); return}
        Alamofire.request(url, method: .post, parameters: params).response { (dataResponse) in
            if let data = dataResponse.data{
                do{
                    let json = try JSONDecoder().decode(TokkensAfterRegistration.self, from: data)
                    print(json)
                } catch {
                    handler(false)
                }
            }
        }
    }
    
    
    
}

