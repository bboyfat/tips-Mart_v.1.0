//
//  MembersModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/2/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation

struct MembersRequest: Codable {
    var lastCreated: Date?
}

struct MembersAnswer: Codable{
    var success: Bool
    var data: [MembersData]?
    var text: String?
}

struct  MembersData: Codable {
    var _user: String
    var userid: Int
    var nickname: String
    var created: Date
    var countOperations: Int
    var invitedMembers: [Int]
    var profitFromFriend: BonusesFromFriends
    var profitFromLines: BonusesFromFriends
}


struct BonusesFromFriends: Codable {
    var grayBalance: Double
    var greenBalance: Double
}
