//
//  RegistrationModels.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation

//MARK: First step Registration
//Struct to send first request after registration to get the AuthCode
struct RegistrationModelRequset: Codable {
    var options: OptionsForRegistration
}
//Struct to send first request after registration to get the AuthCode
struct OptionsForRegistration: Codable {
    #warning("Ask about this property")
    var inviter: String = ""
    var phoneNumber: String
    
}
//Struct to get AuthCode
struct AuthOutput: Codable {
    var success: Bool
    var code: Int
}

//MARK: Second step Registration
//First step of second step, to get the tokkens
struct SecondStepRegistration: Codable {
    var phoneNumber: String
    var authCode: Int
    var password: String
    var inviter: String
}

// Struct to get the tokens after Registration

struct TokkensAfterRegistration: Codable {
    var succes: Bool
    var userid: Int
    var refreshToken: RefresshToken
    var accessToke: AccesToken
}
