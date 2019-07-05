//
//  UserData.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation

struct UsersOutput: Decodable{
    
    var success: Bool?
    var data: UsersData?
    
    
}


struct UsersData: Codable{
    var userid: Int
    var phoneNumber: String
    var name: String
    var surname: String?
    var createdTime: String
    var refreshToken: RefresshToken
    var accessToken: AccesToken
    var balance: Balance
}

struct RefresshToken: Codable{
    var value: String
    var expires: String
}

struct AccesToken: Codable{
    var value: String
    var expires: String
}
struct Balance: Codable{
    var gray: Double
    var green: Double
}
