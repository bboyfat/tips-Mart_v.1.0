//
//  TableShopCell.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

protocol ShopsCellProtocol: class{
    var logoImage: UIImageView!{get set}
    var flameIcon: UIImageView!{get set}
    var selectBtn: UIImageView!{get set}
    var shopName: UILabel!{get set}
    var cashBackUpTobl: UILabel!{get set}
    var cashbackValue: UILabel!{get set}
    var cashbackCurrency: UILabel!{get set}
}

class TableShopCell: UICollectionViewCell, ShopsCellProtocol {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var flameIcon: UIImageView!
    @IBOutlet weak var selectBtn: UIImageView!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var cashBackUpTobl: UILabel!
    @IBOutlet weak var cashbackValue: UILabel!
    @IBOutlet weak var cashbackCurrency: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
