//
//  PurchaseDetailView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/24/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class PurchaseDetailView: UIView {
    @IBOutlet weak var operationID: UILabel!
    @IBOutlet weak var operationState: UILabel!
    @IBOutlet weak var shopNameLbl: UILabel!
    @IBOutlet weak var sumPurchaseLbl: UILabel!
    @IBOutlet weak var cashbackSum: UILabel!
    @IBOutlet weak var createdLbl: UILabel!
    @IBOutlet weak var updatedLbl: UILabel!
    
    @IBOutlet weak var shopLbl: UILabel!
    @IBOutlet weak var operSumLbl: UILabel!
    @IBOutlet weak var cashSumLbl: UILabel!
    @IBOutlet weak var createdLblLocalize: UILabel!
    @IBOutlet weak var updatedLblLocalize: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        localize()
    }
    
    private func localize(){
        shopLbl.text = NSLocalizedString("shop", comment: "")
            operSumLbl.text = NSLocalizedString("transAmount", comment: "")
            cashSumLbl.text = NSLocalizedString("cashSum", comment: "")
            createdLblLocalize.text = NSLocalizedString("createdLoc", comment: "")
            updatedLblLocalize.text = NSLocalizedString("updatedLock", comment: "")
    }
}
