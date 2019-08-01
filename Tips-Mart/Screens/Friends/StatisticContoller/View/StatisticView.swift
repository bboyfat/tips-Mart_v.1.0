//
//  StatisticView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/19/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class StatisticView: UIView {
    @IBOutlet weak var creditedBtn: UIButton!
    @IBOutlet weak var pendingBtn: UIButton!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var membersBtn: UIButton!
    @IBOutlet weak var operationsBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
