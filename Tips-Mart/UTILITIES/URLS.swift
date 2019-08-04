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
    case authURL = "https://tips-mart.com/auth/auth-code"
    case regURL = "https://auth.tips-mart.com/app-client/registration"
    case login = "https://auth.tips-mart.com/app-client/login"
    case userInit = "https://app-client.tips-mart.com/user/init"
    case changeInfo = "https://update.tips-mart.com/profile/settings"
    case notifications = "https://app-client.tips-mart.com/user/notifications"
    case selectedShopsUrl = "https://app-client.tips-mart.com/user/selected_shops"
    case shopInfo = "https://app-client.tips-mart.com/shops/"
    case shopsInfo = "https://tips-mart.com/files/shops.json"
    case refreshToken = "https://auth.tips-mart.com/app-client/token"
    case refreshBalance = "https://app-client.tips-mart.com/user/balance"
    case referalsIncome = "https://app-client.tips-mart.com/profile/v1/user"
    case purchasesInfo = "https://app-client.tips-mart.com/purchases"
    case purchaseState = "https://app-client.tips-mart.com/purchases/state"
    case profileStatistics = "https://app-client.tips-mart.com/referrals/statistics"
    case friendsInfo = "https://app-client.tips-mart.com/referrals/income"
    case membersInfo = "https://app-client.tips-mart.com/referrals/friends"
    case ousInfo = "https://app-client.tips-mart.com/referrals/purchases"
}
