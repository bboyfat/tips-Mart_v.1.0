//
//  CategoryModels.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/11/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation


struct CategoriesAdapter {
    var categoryID: Int
    var name: String
    var subCategories: [SubCategory]
    var switchTable: SwithcForTable = .closed
}



struct Categories: Codable{
    var categoryID: Int
    var name: String
    var subCategories: [SubCategory]
    
    
}

struct SubCategory: Codable {
    var categoryID: Int
    var name: String
}
