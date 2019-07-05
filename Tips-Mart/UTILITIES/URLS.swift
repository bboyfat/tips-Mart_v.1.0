//
//  URLS.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation

import Foundation

//reachebi
enum URLS: String{
    case authURL = "https://app-client.tips-mart.com/auth/v1/registration"
    case login = "https://app-client.tips-mart.com/auth/v1/login"
    case changeInfo = "https://app-client.tips-mart.com/profile/v1/change-data"
    
    case shopsInfo = "https://tips-mart.com/files/shops.json"
    case refreshToken = "https://app-client.tips-mart.com/auth/v1/refresh-token"
    case refreshBalance = "https://app-client.tips-mart.com/home/v1/load-page"
    case referalsIncome = "https://app-client.tips-mart.com/profile/v1/user"
    case purchasesInfo = "https://app-client.tips-mart.com/profile/v1/purchases"
}
