//
//  WDController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/23/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class WDController: UIViewController {
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var cardView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorder()
        
    }
    
    func setBorder(){
        phoneView.layer.borderWidth = 1
        cardView.layer.borderWidth = 1
        phoneView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        cardView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
    }
    
    
}
