//
//  WDView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/23/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class WDView: UIView {
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    var isCard = false{
        didSet{
            
            }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBorder()
        addTargets()
    }
    private func addTargets(){
        phoneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePhone)))
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCard)))
    }
    
    @objc func handlePhone(){
        isCard = false
        
      switchBorderColoe(isIt: isCard)
        
    }
    @objc func handleCard(){
        isCard = true
        switchBorderColoe(isIt: isCard)
    }
    func switchBorderColoe(isIt: Bool){
        switch isIt {
        case true:
            cardView.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.1098039216, blue: 0.6392156863, alpha: 1)
            phoneView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
            cardView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 1, alpha: 1)
            phoneView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case false:
            phoneView.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.1098039216, blue: 0.6392156863, alpha: 1)
            cardView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
            phoneView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 1, alpha: 1)
            cardView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    func setBorder(){
        phoneView.layer.borderWidth = 1
        cardView.layer.borderWidth = 1
        phoneView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        cardView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        
    }
    
    
}
