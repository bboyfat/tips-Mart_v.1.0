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
    @IBOutlet weak var moreDetailsBtn: UIButton!
    
    @IBOutlet weak var statisticLbl: UILabel!
    @IBOutlet weak var pendingLbl: UILabel!
    @IBOutlet weak var creditedLbl: UILabel!
    @IBOutlet weak var operationsLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        segmentController.setTitle(NSLocalizedString("friends", comment: ""), forSegmentAt: 0)
        segmentController.setTitle(NSLocalizedString("familiars", comment: ""), forSegmentAt: 1)
        segmentController.setTitle(NSLocalizedString("strangers", comment: ""), forSegmentAt: 2)
        pendingLbl.text = NSLocalizedString("pending", comment: "")
        operationsLbl.text = NSLocalizedString("operations", comment: "")
        creditedLbl.text = NSLocalizedString("credited", comment: "")
        membersLbl.text = NSLocalizedString("members", comment: "")
        statisticLbl.text = NSLocalizedString("statisticLbl", comment: "")
        moreDetailsBtn.setTitle(NSLocalizedString("More Details", comment: ""), for: .normal)
    }
    
}
