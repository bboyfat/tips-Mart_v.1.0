//
//  CategoryModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/11/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//


import Foundation



enum CategorieType{
    case products
    case services
    case online
    
}

class CategoryModel{
    
    var onlineIfflineArray: [CategoriesAdapter] = [CategoriesAdapter(categoryID: 0, name: "Онлайн", subCategories: [], switchTable: .closed), CategoriesAdapter(categoryID: 0, name: "Оффлайн", subCategories: [], switchTable: .closed)]
    
    
    
    func throwData(categorieType: CategorieType) -> [CategoriesAdapter] {
        switch categorieType {
        case .products:
            
            return parseJson(forResource: "products")
        case .services:
            return parseJson(forResource: "services")
        case .online:
            return onlineIfflineArray
        }
    }
    
    func parseJson(forResource: String) -> [CategoriesAdapter]{
        var categories: [CategoriesAdapter] = []
        do{
            let path = Bundle.main.path(forResource: forResource, ofType: "json")
            guard let checkedPath = path else { return []}
            let fileURl = URL(fileURLWithPath: checkedPath)
            let datA = try Data(contentsOf: fileURl)
            let json = try JSONDecoder().decode([Categories].self, from: datA)
            
            json.forEach { (categori) in
                let category = CategoriesAdapter(categoryID: categori.categoryID, name: categori.name, subCategories: categori.subCategories, switchTable: .closed)
                categories.append(category)
            }
            
        } catch let jsErr {
            print(jsErr)
        }
        return categories
    }
    
}
