//
//  MainPageView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/8/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class MainPageView: UIView {

    @IBOutlet weak var myCardBtn: UIButton!
    @IBOutlet weak var otherCardsBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornersForButtons()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func setCornersForButtons(){
        // settings for bottom
        otherCardsBtn.clipsToBounds = true
        otherCardsBtn.layer.cornerRadius = 10
        otherCardsBtn.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        // settings for top
        myCardBtn.clipsToBounds = true
        myCardBtn.layer.cornerRadius = 10
        myCardBtn.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
  
    
}
