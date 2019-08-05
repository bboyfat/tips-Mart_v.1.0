//
//  MoreView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/31/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class MoreView: UIView {
    
    
    @IBOutlet weak var nicknameLbl: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var greenBalance: UILabel!
    @IBOutlet weak var grayBalance: UILabel!
    
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var reviewView: UIView!
    
    @IBOutlet weak var selectedShopsView: UIView!
    @IBOutlet weak var allShopsView: UIView!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var bonusesView: UIView!
    @IBOutlet weak var wdView: UIView!
    @IBOutlet weak var purchHistoryView: UIView!
    
    var logoutDidTapped: ()->() = {}
    var reviewDidTapped: ()->() = {}
    
    var selectedShopsDidTapped: ()->() = {}
    var allShopsDidTapped: ()->() = {}
    
    var profileDidTapped: ()->() = {}
    var bonusesDidTapped: ()->() = {}
    var wdDidTapped: ()->() = {}
    var purchHistoryDidTapped: ()->() = {}
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTargets()
    }
    
    func addTargets(){
        logoutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLogout)))
         reviewView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleReview)))
        
         selectedShopsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectedShops)))
         allShopsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAllShops)))
        
         bonusesView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBonuses)))
         wdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleWd)))
         purchHistoryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePurchHistory)))
         profileView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfile)))
    }

    @objc func handleLogout(){
        logoutDidTapped()
    }
    @objc func handleReview(){
        reviewDidTapped()
    }
    @objc func handleSelectedShops(){
        selectedShopsDidTapped()
    }
    
    @objc func handleAllShops(){
        allShopsDidTapped()
    }
    @objc func handleProfile(){
        profileDidTapped()
    }
    
    
    @objc func handleBonuses(){
        bonusesDidTapped()
    }
    @objc func handleWd(){
        wdDidTapped()
    }
    @objc func handlePurchHistory(){
        purchHistoryDidTapped()
    }
   
}
