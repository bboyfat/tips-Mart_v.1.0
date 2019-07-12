//
//  ShopsDatRealm.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/10/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import RealmSwift

class ShopDataRealm: Object{
    
    @objc dynamic var url: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var shopID: Int = 0
    @objc dynamic var pathImage: String = ""
    var categories = List<Int>()
    @objc dynamic var currency = ""
    @objc dynamic var value = 0.0
    @objc dynamic var isSelected = false
    
}

