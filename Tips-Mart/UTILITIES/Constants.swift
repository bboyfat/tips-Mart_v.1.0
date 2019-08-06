//
//  Constants.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/10/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation

//Token
var accessToken = { UserDefaults.standard.value(forKey: "accessToken") as? String }
var refreshToken = {UserDefaults.standard.value(forKey: "refreshToken") as? String}
var accessExpires = {UserDefaults.standard.value(forKey: "accessExpires") as? Double}
var refreshExpires = {UserDefaults.standard.value(forKey: "refreshExpires") as? Double}
//AUTHCODE
var authCode = {UserDefaults.standard.value(forKey: "authCode") as? Int}
//Error
var loginError = {UserDefaults.standard.value(forKey: "loginError") as? String}
//USERS DATA
var userId = {UserDefaults.standard.value(forKey: "userId") as? Int}
var nickname = {UserDefaults.standard.value(forKey: "nickname") as? String}
//BALANCE
let greenBalance = {UserDefaults.standard.value(forKey: "greenBalance") as? Double}
let grayBalance = {UserDefaults.standard.value(forKey: "grayBalance") as? Double}
//Created
let createdAccDate = {UserDefaults.standard.value(forKey: "created") as? String}
