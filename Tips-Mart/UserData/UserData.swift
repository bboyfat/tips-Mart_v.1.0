//
//  UserData.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

//MARK: Login
struct UsersOutput: Codable{
    var success: Bool?
    var data: UsersData?
}
// struct for getting data after login
struct UsersData: Codable{
    var userid: Int
    var phoneNumber: String
    var name: String
    var surname: String?
    var created: String
    
}
//MARK: Tokens
struct LoginToken: Codable {
    var success: Bool?
    var data: Tokens?
    var text: String?
}

struct Tokens: Codable {
    var accessToken: AccesToken
    var refreshToken: RefresshToken
}
// Tokens
struct RefresshToken: Codable{
    var value: String
    var expires: Double
}

struct AccesToken: Codable{
    var value: String
    var expires: Double
}
//MARK: Balance
struct Balance: Codable {
    var success: Bool?
    var data: BalanceData?
    var text: String?
}

struct BalanceData: Codable{
    var grayBalance: Double
    var greenBalance: Double
}


//MARK:NOTIFICATIONS
struct Notifications: Codable {
    var success: Bool?
    var data: NotificationsData?
    var text: String?
}

struct NotificationsData: Codable{
    var type: Int
    var headline: String
    var description: String
    var created: String
}
//MARK: Selected SHOPS
struct SelectedShops: Codable {
    var success: Bool?
    var data: [String]
}

//MARK: One Shop Info

struct Shop: Codable {
    var success: Bool?
    var data: ShopData?
}
struct ShopData: Codable {

    var status: Int
    var timeProcessing: String
    var description: String
    var warningInfo: String
    var refLink: String
    var  created: String
    var rating: Rating
    var listCashbacks: ListCashBack
   
}

struct Rating: Codable {
    var countReviews: Int
    var countRatings: Int
    var totalStars : Int
}

struct ListCashBack: Codable {
    var name: String
    var value: String
    var typeCurrency: String
}


//MARK: SHOPS REQUEST MODEL

struct ShopsModel: Decodable {
    var shopID: Int
    var type: String
    var name: String
    var isSelected: Bool?
    var pathToShop: String
    var pathToImage: String
    var maxCashback: Cashback
    var categories: [Int]
}


struct Cashback: Decodable {
    var typeCurrency: String
    var value: Double
}

struct ImageLogo{
    var image: UIImage
}

