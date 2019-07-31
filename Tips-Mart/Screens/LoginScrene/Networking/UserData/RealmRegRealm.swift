//
//  RealmLogRegxRealm.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/3/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import RealmSwift


class RealmUserData: Object{
    @objc dynamic var nickname: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var created: String = ""
}
