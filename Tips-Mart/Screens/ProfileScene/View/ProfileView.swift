//
//  ProfileView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/31/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!

    @IBOutlet weak var bonusLbl: UILabel!
    @IBOutlet weak var invaitedLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var totalCashback: UILabel!
    @IBOutlet weak var operationsCountLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
