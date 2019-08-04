//
//  Constants.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/10/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation


var accessToken = { UserDefaults.standard.value(forKey: "accessToken") as? String }
var refreshToken = {
    UserDefaults.standard.value(forKey: "refreshToken") as? String
}
var accessExpires = {UserDefaults.standard.value(forKey: "accessExpires") as! Double}
var refreshExpires = {UserDefaults.standard.value(forKey: "refreshExpires") as! Double}

var authCode = {UserDefaults.standard.value(forKey: "authCode") as! Int}

var loginError = {UserDefaults.standard.value(forKey: "loginError") as? String}

var userId = {UserDefaults.standard.value(forKey: "userId") as? Int}
