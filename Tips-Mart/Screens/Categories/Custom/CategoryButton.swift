//
//  CategoryButton.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/11/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit


class CategoryButton: UIButton {
    
    var isSelect: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(handleAgree), for: .touchUpInside)
        
    }
    
    @objc func handleAgree(){
        isSelect = !isSelect
        if isSelect {
            setImage(#imageLiteral(resourceName: "selected"), for: .normal)
        } else {
            setImage(#imageLiteral(resourceName: "notSelected"), for: .normal)
        }
        
        
    }
    
}
