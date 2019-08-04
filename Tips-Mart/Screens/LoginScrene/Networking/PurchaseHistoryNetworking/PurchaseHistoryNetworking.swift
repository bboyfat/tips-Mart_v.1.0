//
//  PurchaseHistoryNetwirking.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/24/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import Alamofire

protocol PurchaseServiceProtocol: class {
    associatedtype model: Codable
    func sendRequest(with params: model, handler: @escaping(_ model: [PurchaseObject]) ->())
}


class PurchaseHistoryNetworking: PurchaseServiceProtocol{
   
    typealias model = PurchaseReqData
//    let params: NSMutableDictionary = NSMutableDictionary()
//    params.setValue(model.name, forKey: "name")
//    params.setValue(model.surname, forKey: "surname")
//    params.setValue(model.birthday, forKey: "birthday")
//    params.setValue(model.maritalStatus, forKey: "maritalStatus")
//
//    let header = accessToken
//    let jsonDatasonData = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
//    let optionsObject = NSString(data: jsonDatasonData!, encoding: String.Encoding.utf8.rawValue)! as String
//    let postParamsString = "data=\(optionsObject)"
//
//
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//
//    request.httpBody = postParamsString.data(using: String.Encoding.utf8)
//    request.addValue("Bearer \(header)", forHTTPHeaderField: "Authorization")
//    let session = URLSession.shared
//    session.dataTask(with: request) { (data, response, error) in
//    guard let data = data else {return}
//
//    do{
//    let answer = try JSONSerialization.jsonObject(with: data, options: [])
//    print(answer)
//
//
//    } catch {
//    print("!!!!!!!!!!!!!!!!!!OOPS, we have an error",error)
//    }
//    }.resume()
//}


    func sendRequest(with params: PurchaseReqData, handler: @escaping ([PurchaseObject]) -> ()) {
        guard let url = URL(string: URLS.purchasesInfo.rawValue) else {return}
        //prepare dictionary to convert it to stringify JSON
       let mutableParams = NSMutableDictionary()
        mutableParams.setValue(params.data.createdFrom, forKey: "createdFrom")
        mutableParams.setValue(params.data.createdTo, forKey: "createdTo")
        mutableParams.setValue(params.data.isArchived, forKey: "isArchived")
        mutableParams.setValue(params.data.statuses, forKey: "statuses")
        
        //convert mutable params to data
        let jsonDatasonData = try? JSONSerialization.data(withJSONObject: mutableParams, options: JSONSerialization.WritingOptions())
        //convert data to String
        let purchDataString = NSString(data: jsonDatasonData!, encoding: String.Encoding.utf8.rawValue)! as String
        let purchDataFinalString = "data=\(purchDataString)"
        //create a URLRequest with header and body
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = purchDataFinalString.data(using: String.Encoding.utf8)
        guard let token = accessToken() else {return}
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //creating a url session
        let session = URLSession.shared
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data{
                do{
                    let answer = try JSONDecoder().decode(PurchaseData.self, from: data)
                    handler(answer.data)
                } catch let answerErr {
                    print(answerErr)
                }
            }
            if let err = error{
                print(err)
            }
        }.resume()
        
    }
    
}

class PurchaseStateService: NetworkServiceProtocol{
    
    typealias loginModel = PurchaseStateModel
    
    func sendRequest(with params: PurchaseStateModel, handler: @escaping (Bool) -> ()) {
        let data = try! JSONEncoder().encode(params)
        guard let params = try! JSONSerialization.jsonObject(with: data, options: []) as? Parameters else { handler(false); return }
        guard let url = URL(string: URLS.purchaseState.rawValue) else { handler(false); return}
        Alamofire.request(url, method: .post, parameters: params).response { (dataResponse) in
            if let data = dataResponse.data{
                do{
                    let json = try JSONDecoder().decode(StateAnswer.self, from: data)
                    print(json)
                } catch let err {
                    print(err)
                    handler(false)
                }
            }
        }
        
    }
    
}
