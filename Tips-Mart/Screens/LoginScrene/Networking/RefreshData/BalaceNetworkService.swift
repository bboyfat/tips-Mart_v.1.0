//
//  BalaceNetworkService.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift

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
    let notificationCenter = NotificationCenter.default
    var shopsDataService: ShopsDataBaseProtocol!
    func sendRequest(handler: @escaping (Bool) -> ()) {
        guard let url = URL(string: URLS.shopsInfo.rawValue) else { handler(false); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode([ShopsModel].self, from: response)
                    //Saving data to realm
                    if self.checkDataRealm(answer: answer){
                        self.shopsDataService = ShopsDataBaseService(model: answer)
                        self.shopsDataService.saveShopsToData()
                    }
                    
                    handler(true)
                    self.notificationCenter.post(name: NSNotification.Name.savingIsFinished, object: self)
                } catch let shopErr{
                    print("MainShopRequestError", shopErr)
                    handler(false)
                }
            }
        }
    }
    
    // private func to check if there something new with shops
    private func checkDataRealm(answer: [ShopsModel]) -> Bool{
        var shopsModelArray: [ShopDataRealm] = []
        do{
            let realm = try Realm()
            shopsModelArray = Array(realm.objects(ShopDataRealm.self))
        } catch {
            print("Can't FETCH!!")
        }
        if shopsModelArray.count != answer.count || shopsModelArray.count == 0{
            return true
        } else {
            return false
        }
    }
}
//Object to get Logo

class LogoNetworkService{
    
    func getImages(with path: String, handler: @escaping (UIImage?) -> Void){
        
        guard let url = URL(string: "https://tips-mart.com/images/shops/\(path)/logotype.svg") else { return }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .useProtocolCachePolicy
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                print("cant get an image", error)
            }
            if let data = data{
                guard let image = UIImage(data: data) else {return}
                handler(image)
            } else {
                handler(nil)
            }

            }.resume()

    }
    
}
