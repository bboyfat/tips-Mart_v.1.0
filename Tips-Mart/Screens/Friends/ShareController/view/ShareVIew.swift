//
//  ShareVIew.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/18/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ShareVIew: UIView {

    @IBOutlet weak var linkView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        linkView.layer.borderWidth = 1
        linkView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
    }

}
