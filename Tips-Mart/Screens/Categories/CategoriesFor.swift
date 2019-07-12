//
//  CategoriesFor.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/11/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import NotificationCenter

enum CategoriesFor{
    case map
    case shops
}

class CategoriesForFilter{
    
    static let shared = CategoriesForFilter()
    
    var filteredShopsCount: Int = 0 {
        didSet{
            postNotigication()
        }
    }
    var categories: [Int] {
        didSet{
            postNotigication()
        }
    }
    
    func postNotigication(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Filtered"), object: self)
    }
    
    
    private init(){
        categories = []
    }
    
}
