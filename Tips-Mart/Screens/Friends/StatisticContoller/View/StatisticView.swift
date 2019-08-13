//
//  StatisticView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/19/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class StatisticView: UIView {
    @IBOutlet  var creditedBtn: UIButton!
    @IBOutlet  var pendingBtn: UIButton!
    @IBOutlet  var segmentController: UISegmentedControl!
    @IBOutlet  var percentLabel: UILabel!
    @IBOutlet  var membersBtn: UIButton!
    @IBOutlet  var operationsBtn: UIButton!
    @IBOutlet  var moreDetailsBtn: UIButton!
    
    @IBOutlet var statisticLbl: UILabel!
    @IBOutlet var pendingLbl: UILabel!
    @IBOutlet var creditedLbl: UILabel!
    @IBOutlet var operationsLbl: UILabel!
    @IBOutlet var membersLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        checkNil()
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
    
    
    func checkNil(){
        if membersBtn == nil || operationsBtn == nil ||  pendingBtn == nil || creditedBtn == nil{
            membersBtn = UIButton()
            operationsBtn = UIButton()
            pendingBtn = UIButton()
            creditedBtn = UIButton()
            segmentController = UISegmentedControl()
            percentLabel = UILabel()
            statisticLbl = UILabel()
            pendingLbl = UILabel()
            operationsLbl = UILabel()
            creditedLbl = UILabel()
            membersLbl = UILabel()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
          checkNil()
    }
   
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
