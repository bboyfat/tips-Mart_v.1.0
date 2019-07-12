//
//  RowCatCell.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/11/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

protocol CategoriesCell: UITableViewCell {
    
}

class RowsCatCell: UITableViewCell, CategoriesCell {
    
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var shopsCountlbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            accessoryType = .checkmark
        } else {
            accessoryType = .none
        }
        
    }
    
}
