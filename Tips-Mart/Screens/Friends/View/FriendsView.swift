//
//  FriendsView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/18/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class FriendsView: UIView {

    @IBOutlet weak var totalBonusBtnLbl: UILabel!
    @IBOutlet weak var strangersBtnOutlet: UIButton!
    @IBOutlet weak var familiarsBtnOutlet: UIButton!
    @IBOutlet weak var friendsBtnOutlet: UIButton!
    @IBOutlet weak var moreDetailsBanner: UIImageView!
    var moreDetailsPressed: () -> () = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        moreDetailsBanner.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMoreDetails)))
    }
    
    @objc func handleMoreDetails(){
        moreDetailsPressed()
    }

}
