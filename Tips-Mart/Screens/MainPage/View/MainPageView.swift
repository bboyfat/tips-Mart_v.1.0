//
//  MainPageView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/8/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class MainPageView: UIView {

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var profileStackView: UIStackView!
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
        otherCardsBtn.layer.borderWidth = 1.2
        otherCardsBtn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        // settings for top
        myCardBtn.clipsToBounds = true
        myCardBtn.layer.cornerRadius = 10
        myCardBtn.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
  
    
}
