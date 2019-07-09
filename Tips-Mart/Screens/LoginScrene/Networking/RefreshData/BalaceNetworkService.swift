//
//  BalaceNetworkService.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import Alamofire
//NETWORK SERVICE TO REFRESH BALANCE

class BalanceNetworkService: NetworkServiceProtocol{
    
    typealias loginModel = Tokens
    
    func sendRequest(with params: Tokens, handler: @escaping (Bool) -> ()) {
        
        guard let url = URL(string: URLS.refreshBalance.rawValue) else { handler(false); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        urlRequest.addValue("Bearer \(params.accessToken.value)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode(Balance.self, from: response)
                    print(answer)
                    
                } catch{
                    print(Error.self)
                }
            }
        }
    }
    
}

//NETWORK SERVICE TO REFRESH Notifications
class NotificationsNetworkService: RefreshServiceProtocol{
    var accessToken: String = ""
    
    func sendRequest(handler: @escaping (Bool) -> ()) {
        guard let url = URL(string: URLS.notifications.rawValue) else { handler(false); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode(Notifications.self, from: response)
                    print(answer)
                    
                } catch{
                    print(Error.self)
                }
            }
        }
    }
}

//NETWORK SERVICE TO GET SELECTED SHOPS ARRAY


class SelectedShopsNetworkService: RefreshServiceProtocol{
    var accessToken: String = ""
    func sendRequest(handler: @escaping (Bool) -> ()) {
        guard let url = URL(string: URLS.selectedShops.rawValue) else { handler(false); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode(SelectedShops.self, from: response)
                    print(answer)
                    
                } catch{
                    print(Error.self)
                }
            }
        }
    }
}

//NETWORK SERVICE TO GET ONE SHOPS

class ShopNetworkService: RefreshServiceProtocol{
    
    var accessToken: String = ""
    var pathToShop: String!
    func sendRequest(handler: @escaping (Bool) -> ()) {
        guard let url = URL(string: URLS.shopInfo.rawValue + pathToShop) else { handler(false); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode(Shop.self, from: response)
                    print(answer)
                    
                } catch{
                    print(Error.self)
                }
            }
        }
    }
    
    init(pathToshop: String) {
        self.pathToShop = pathToshop
    }
}

//MARK: MAINSHOPS Request

class MainShopsNetworkService: RefreshServiceProtocol{
    
    var accessToken: String = ""
    
    func sendRequest(handler: @escaping (Bool) -> ()) {
        guard let url = URL(string: URLS.shopsInfo.rawValue) else { handler(false); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode([ShopsModel].self, from: response)
                    print(answer)
                } catch{
                    print(Error.self)
                }
            }
        }
    }
}
