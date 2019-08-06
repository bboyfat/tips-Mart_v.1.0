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

class BalanceNetworkService{
    
    func sendRequest(handler: @escaping (Bool) -> ()) {
        
        guard let url = URL(string: URLS.refreshBalance.rawValue) else { handler(false); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        guard let token = accessToken() else {return}
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode(Balance.self, from: response)
                    print(answer)
                    UserDefaults.standard.set(answer.data?.greenBalance, forKey: "greenBalance")
                    UserDefaults.standard.set(answer.data?.grayBalance, forKey: "grayBalance")
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
        guard let token = accessToken() else {return}
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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

//NETWORK SERVICE TO GET ONE SHOP

class ShopNetworkService{
    
    
    var pathToShop: String!
    
    func sendRequest(handler: @escaping (Shop) -> ()) {
        guard let url = URL(string: URLS.shopInfo.rawValue + pathToShop) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        guard let token = accessToken() else {return}
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode(Shop.self, from: response)
                    print(answer)
                    handler(answer)
                } catch let shopErr{
                    print(shopErr)
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
    
    var shopsDataService: ShopsDataBaseProtocol!
    
    func sendRequest(handler: @escaping (Bool) -> ()) {
        guard let url = URL(string: URLS.shopsInfo.rawValue) else { handler(false); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        guard let token = accessToken() else {return}
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode([ShopsModel].self, from: response)
                    //Saving data to realm
                    self.shopsDataService = ShopsDataBaseService(model: answer)
                    self.shopsDataService.ifHasChanges()
                    handler(true)
                } catch let shopErr{
                    print("MainShopRequestError", shopErr)
                    handler(false)
                }
            }
        }
    }
    
    
}
//NETWORK SERVICE TO GET SELECTED SHOPS ARRAY
class SelectedShopsService{
    
    
    
    func sendRequest(handler: @escaping ([String]) -> ()) {
        guard let url = URL(string: URLS.selectedShopsUrl.rawValue) else { handler([]); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        guard let token = accessToken() else {return}
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode(SelectedShops.self, from: response)
                    
                    handler(answer.data)
                    
                } catch let shopErr{
                    print("MainShopRequestError", shopErr)
                    handler([])
                }
            }
        }
    }
    
    
}
//Object to get Logo

class LogoNetworkService{
    
    func getImages(with path: String, handler: @escaping (UIImage?) -> Void){
        
        guard let url = URL(string: "https://tips-mart.com/images/shops/\(path)/logotype.png") else { return }
        
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
//Final step of fucking registration
class UserSettingsNetwork: RefreshServiceProtocol{
    
    var model: UserProfile!
    func sendRequest(handler: @escaping (Bool) -> ()) {
        guard let url = URL(string: URLS.changeInfo.rawValue) else { handler(false); return}
        
        let params: NSMutableDictionary = NSMutableDictionary()
        params.setValue(model.name, forKey: "name")
        params.setValue(model.surname, forKey: "surname")
        params.setValue(model.birthday, forKey: "birthday")
        params.setValue(model.email, forKey: "email")
        params.setValue(model.maritalStatus, forKey: "maritalStatus")
        
        guard let header = accessToken() else {return}
        let jsonDatasonData = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
        let optionsObject = NSString(data: jsonDatasonData!, encoding: String.Encoding.utf8.rawValue)! as String
        let postParamsString = "data=\(optionsObject)"
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = postParamsString.data(using: String.Encoding.utf8)
        request.addValue("Bearer \(header)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            
            do{
                let answer = try JSONSerialization.jsonObject(with: data, options: [])
                print(answer)
                
                handler(true)
            } catch {
                print("!!!!!!!!!!!!!!!!!!OOPS, we have an error",error)
                handler(false)
            }
            }.resume()
    }
    
    init(model: UserProfile) {
        self.model = model
    }
    
    
    
}
// Object that will get data for Profile screen
class ProfileNetworkService{
    
    func sendRequest(handler: @escaping (ProfilesData?) -> ()) {
        guard let url = URL(string: URLS.profileStatistics.rawValue) else { handler(nil); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        guard  let token = accessToken() else {return}
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let json = try JSONSerialization.jsonObject(with: response, options: [])
                    print(json)
                    let answer  = try JSONDecoder().decode(ProfileAnswer.self, from: response)
                    
                    handler(answer.data)
                    
                } catch let profErr{
                    print("ProfileNetworkService", profErr)
                    handler(nil)
                }
            }
        }
    }
    
    
}
// Object that getting data for friends screen
class FriendsNetworkService{
    
    func sendRequest(handler: @escaping ([Referals]?) -> ()) {
        guard let url = URL(string: URLS.friendsInfo.rawValue) else { handler(nil); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        guard let token = accessToken() else {return}
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode(FriendsAnswer.self, from: response)
                    handler(answer.data)
                } catch let profErr{
                    print("ProfileNetworkService", profErr)
                    handler(nil)
                }
            }
        }
    }
    
    
}
//Objec that getting data about referals
class MembersNetworkService{
    var model: MembersRequest!
    func sendRequest(handler: @escaping ([MembersData]?) -> ()) {
        guard let url = URL(string: URLS.membersInfo.rawValue) else { handler(nil); return}
        
        guard let data = try? JSONEncoder().encode(model) else {return}
        guard let params = try? JSONSerialization.jsonObject(with: data, options: []) as? Parameters else {return}
        guard let token = accessToken() else {return}
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        Alamofire.request(url, method: .post, parameters: params, headers: header).responseJSON { (dataReponse) in
            if let data = dataReponse.data{
                do{
                    let answer  = try JSONDecoder().decode(MembersAnswer.self, from: data)
                    handler(answer.data)
                    OperationQueue.main.addOperation {
                        handler(answer.data)
                    }
                } catch let err{
                    print(err)
                }
            }
        }
        
    }
    
    init(model: MembersRequest) {
        self.model = model
    }
    
    
}

class OUSNetworkService{
    
    var model: OUSRequest!
    
    func sendRequest(handler: @escaping ([OUSData]?) -> ()) {
        //        let data = try! JSONEncoder().encode(model)
        //        guard let params = try? JSONSerialization.jsonObject(with: data, options: []) as! Parameters else {return}
        guard let url = URL(string: URLS.ousInfo.rawValue) else { handler(nil); return}
        
        let params: NSMutableDictionary = NSMutableDictionary()
        params.setValue(model._user, forKey: "_user")
        params.setValue(model.statuses, forKey: "statuses")
        params.setValue(model.createdFrom, forKey: "createdFrom")
        params.setValue(model.createdTo, forKey: "createdTo")
        
        guard let header = accessToken() else {return}
        let jsonDatasonData = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
        let optionsObject = NSString(data: jsonDatasonData!, encoding: String.Encoding.utf8.rawValue)! as String
        let postParamsString = "data=\(optionsObject)"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = postParamsString.data(using: String.Encoding.utf8)
        request.addValue("Bearer \(header)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                let answer = try JSONDecoder().decode(OUSAnswer.self, from: data)
                print(answer)
                OperationQueue.main.addOperation {
                    handler(answer.data)
                }
                
            } catch {
                print("OUSNetworkService",error)
            }
            }.resume()
    }
}

//Objec that getting data to change Profile
class ProfielEditNetService{
    func sendRequest(handler: @escaping (ProfileData?) -> ()) {
        guard let url = URL(string: URLS.getInfo.rawValue) else { handler(nil); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        guard let token = accessToken() else {return}
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let json = try JSONSerialization.jsonObject(with: response, options: [])
                    print(json)
                    let answer  = try JSONDecoder().decode(ProfileEditModel.self, from: response)
                    OperationQueue.main.addOperation {
                        handler(answer.data)
                    }
                    
                } catch let profErr{
                    print("ProfielEditNetService", profErr)
                    handler(nil)
                }
            }
        }
    }
    
}
//Object that will send the data to API wit shop name
class BuyingNetworkService{
    var pathToShop: String!
    func sendRequest(handler: @escaping (Bool) -> ()) {
        
        guard let url = URL(string:"https://app-client.tips-mart.com/shops/\(pathToShop!)/view" ) else { handler(false); return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        guard let token = accessToken() else {return}
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.data{
                do{
                    let answer  = try JSONDecoder().decode(Balance.self, from: response)
                    if answer.success ?? false{
                        handler(true)
                    } else {
                        handler(false)
                    }
                    
                } catch{
                    print(Error.self)
                }
            }
        }
    }
    init(path: String) {
        self.pathToShop = path
    }
    
}


