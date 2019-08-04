//
//  OUSModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/2/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
// Struct to send request
struct OUSRequest: Codable {
    var _user: String
    var statuses: [Int]?
    var createdFrom: Int? //    Date (Unix)    Начиная с..
    var createdTo: Int?// (Unix)
  
}
//Structs to get answer
struct OUSAnswer: Codable{
    var success: Bool
    var data : [OUSData]?
    var text: String?
}

struct OUSData: Codable{
    var status: Int
    var cashbackID: String
    var created: Int
    var userCashback: Double
}
