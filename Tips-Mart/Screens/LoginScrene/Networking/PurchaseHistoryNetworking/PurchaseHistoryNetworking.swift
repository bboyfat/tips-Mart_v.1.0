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
   
    typealias model = PurchaseReq
    
    func sendRequest(with params: PurchaseReq, handler: @escaping ([PurchaseObject]) -> ()) {
        let data = try! JSONEncoder().encode(params)
        guard let params = try! JSONSerialization.jsonObject(with: data, options: []) as? Parameters else {  return }
        let header: HTTPHeaders = [
            "Authorization": accessToken
        ]
        guard let url = URL(string: URLS.purchasesInfo.rawValue) else { return}
        Alamofire.request(url, method: .post, parameters: params, headers: header).responseJSON { (dataResponse) in
            if let data = dataResponse.data{
                do{
                    let answer = try JSONDecoder().decode(PurchaseData.self, from: data)
                    print(answer)
                    handler(answer.data)
                } catch let purchErr{
                    print(purchErr)
                }
            }
        }
    }
   
    
    
    
}
