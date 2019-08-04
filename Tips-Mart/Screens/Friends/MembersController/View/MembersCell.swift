//
//  MembersCell.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/19/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class MembersCell: UITableViewCell {

    @IBOutlet weak var familiarsBponusGreen: UILabel!
    @IBOutlet weak var familirsBonusGray: UILabel!
    @IBOutlet weak var strangersCount: UILabel!
    @IBOutlet weak var familiarsCount: UILabel!
    @IBOutlet weak var friendsBonusGray: UILabel!
    @IBOutlet weak var friendsBonusGreen: UILabel!
    @IBOutlet weak var operationsLbl: UILabel!
    @IBOutlet weak var nicknameLbl: UILabel!
    @IBOutlet weak var ifLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
