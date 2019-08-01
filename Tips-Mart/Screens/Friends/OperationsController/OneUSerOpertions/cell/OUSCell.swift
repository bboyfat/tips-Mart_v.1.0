//
//  OUSCell.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/22/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class OUSCell: UITableViewCell {
    @IBOutlet weak var operationIDLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var cahsBackValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
