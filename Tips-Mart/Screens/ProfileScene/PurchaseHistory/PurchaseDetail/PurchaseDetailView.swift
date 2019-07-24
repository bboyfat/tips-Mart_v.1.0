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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

}
