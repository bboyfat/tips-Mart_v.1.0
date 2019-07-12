//
//  CategoruCellModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/11/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation


class SelectedModel{
    
    static let shared = SelectedModel()
    var indexPath: IndexPath?{
        didSet{
            if let indexPath = self.indexPath{
                if !selectedRowAt.contains(indexPath){
                    self.selectedRowAt.append(indexPath)
                } else {
                    selectedRowAt.remove(indexPath)
                }
            }
        }
    }
    
    var selectedRowAt: [IndexPath]
    
    private init(){
        selectedRowAt = []
    }
}

