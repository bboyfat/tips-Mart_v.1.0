//
//  ProfileEditModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation

struct ProfileEditModel: Codable{
    var success: Bool
    var text: String?
    var data: ProfileData?
}
struct ProfileData: Codable{
    var name: String
    var surname: String
    var birthday: String
}
