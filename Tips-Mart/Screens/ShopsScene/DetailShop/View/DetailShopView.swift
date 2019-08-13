//
//  DetailShopView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/15/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class DetailShopView: UIView {
    
    //MARK: Outlets
    
    @IBOutlet weak var copyIdBtn: UIButton!
    @IBOutlet weak var shoppingRules: UIButton!
    @IBOutlet weak var goToShop: UIButton!
    @IBOutlet weak var logoImageVIew: UIImageView!
    
    @IBOutlet weak var cashBackValueLbl: UILabel!
    @IBOutlet weak var cashbackCurrencyLbl: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var cashbackTimeLbl: UILabel!
    @IBOutlet weak var toSafePurhcLbl: UILabel!
    @IBOutlet weak var purchMadedLbl: UILabel!
    
    @IBOutlet weak var cashBackUpTobl: UILabel!
    @IBOutlet weak var attentionLbl: UILabel!
    @IBOutlet weak var lisCashbackLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLocalized()
        copyIdBtn.addTarget(self, action: #selector(copyId), for: .touchUpInside)
    }
    
    
    func setLocalized(){
        cashBackUpTobl.text = NSLocalizedString("cashbackUpTo", comment: "")
        goToShop.setTitle(NSLocalizedString("goToShop", comment: ""), for: .normal)
        shoppingRules.setTitle(NSLocalizedString("shoppingRules", comment: ""), for: .normal)
        
        toSafePurhcLbl.text = NSLocalizedString("toSafePurchase", comment: "")
        guard let id = userId() else {return}
        purchMadedLbl.text = NSLocalizedString("purchMadedWith", comment: "") + String(id)
    }
    
    
    @objc func copyId(){
        UIPasteboard.general.string = purchMadedLbl.text
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
