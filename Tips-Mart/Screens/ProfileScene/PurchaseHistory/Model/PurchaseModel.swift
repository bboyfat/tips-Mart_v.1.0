//
//  PurchaseModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/24/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation



//Struct to getting answer

struct PurchaseData: Codable {
    var success: Bool
    var data: [PurchaseObject]
}

struct PurchaseObject: Codable, Equatable, Hashable{
    
    static func == (lhs: PurchaseObject, rhs: PurchaseObject) -> Bool {
        return true
    }
    
    var _purchase: String
    var status: Int
    var created: String
    var updated: String
    var cashbackID: String
    var userCashback: Double
    var sumPurchase: Double
    var shopData: ShopObject
   
}

struct ShopObject: Codable, Hashable {
    var name: String
    var pathToImage: String
}


//Struct to send request
struct PurchaseReqData: Codable {
    var data: PurchaseReq
}
struct PurchaseReq: Codable {
    var statuses: [Int]?   //Сортировка по статусам
    var isArchived: Bool?
    var createdFrom: Int?
    var createdTo: Int?
}


//Struct for changing purchase state
enum PurchaseState: String {
    case remove = "isRemoved"
    case archive = "isArchived"
}

struct PurchaseStateModel: Codable{
    var newState: [String]
    var _purchase: String
}

struct StateAnswer: Codable {
    var success: Bool
    var text: String?
}
