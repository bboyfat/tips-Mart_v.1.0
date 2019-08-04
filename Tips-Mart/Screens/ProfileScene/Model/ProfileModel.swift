//
//  ProfileModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/1/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation


struct ProfileAnswer: Codable{
    var success: Bool
    var data: ProfilesData?
    var text: String?
}
struct FriendsAnswer: Codable{
    var success: Bool
    var data: [Referals]?
    var text: String?
}

struct ProfilesData: Codable {
    var referrals: [Referals]
    var personalCashback: PersonalCashback
}

struct Referals: Codable {
    var members: Int
    var orders: Int
    var pending: Double
    var credited: Double
}


struct PersonalCashback: Codable {
    var countPurchases: Int
    var grayBalance: Double
    var greenBalance: Double
}
