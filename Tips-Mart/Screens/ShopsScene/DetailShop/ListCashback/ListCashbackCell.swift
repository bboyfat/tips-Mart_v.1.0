//
//  ListCashbackCell.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/10/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ListCashbackCell: UITableViewCell {

    @IBOutlet weak var cashName: UILabel!
    @IBOutlet weak var cashbackValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
