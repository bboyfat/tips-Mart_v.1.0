//
//  MyCardView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/31/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class MyCardView: UIView {
    
    @IBOutlet weak var nickNameLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var barCodeImage: UIImageView!
    
    @IBOutlet weak var infoViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
