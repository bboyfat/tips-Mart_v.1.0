//
//  RealmLogRegxRealm.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/3/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import RealmSwift


class RealmRegistration: Object{
  
    @objc dynamic var name: String = ""
    @objc dynamic var surName: String = ""
    @objc dynamic var friendsID: String = ""
    @objc dynamic var birthDate: String = ""
}
