//
//  ShopCollectionCell.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ShopCollectionCell: UICollectionViewCell, ShopsCellProtocol {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var flameIcon: UIImageView!
    @IBOutlet weak var selectBtn: UIImageView!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var cashBackUpTobl: UILabel!
    @IBOutlet weak var cashbackValue: UILabel!
    @IBOutlet weak var cashbackCurrency: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cashBackUpTobl.text = NSLocalizedString("cashbackUpTo", comment: "")
    }

}
