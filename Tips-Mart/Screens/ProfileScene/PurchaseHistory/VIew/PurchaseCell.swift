//
//  PurchaseCell.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/17/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class PurchaseCell: UITableViewCell {

    @IBOutlet weak var shopLogo: UIImageView!
    @IBOutlet weak var cashbackSum: UILabel!
    @IBOutlet weak var cashbackState: UILabel!
    @IBOutlet weak var createdTime: UILabel!
    @IBOutlet weak var operationID: UILabel!
    @IBOutlet weak var sumPurchaseLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
