//
//  RegistrationModels.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation


//Struct to send first request after registration to get the AuthCode
//MARK: First step Registration
struct RegistrationModelRequset: Codable {
    var phoneNumber: String
}
//Struct to send first request after registration to get the AuthCode


//Struct to get AuthCode
struct AuthOutput: Codable {
    var success: Bool
    var code: Int?
    var text: String?
}

//MARK: Second step Registration
//First step of second step, to get the tokkens
struct SecondStepRegistration: Codable {
    var phoneNumber: String
    var authCode: Int
    var password: String
    var inviter: String
    var isMobileApp: Bool = true
}

// Struct to get the tokens after Registration

struct TokkensAfterRegistration: Codable {
    var success: Bool
    var data: Tokens
}
