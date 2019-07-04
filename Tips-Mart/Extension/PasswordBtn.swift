//
//  PasswordBtn.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/4/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class PasswordButton: UIButton{
   
    var isAgreed: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkPass()
        self.addTarget(self, action: #selector(handleAgree), for: .touchUpInside)
    }
    
    @objc func handleAgree(){
        isAgreed = !isAgreed
        checkPass()
    }
    func checkPass(){
        if isAgreed {
            setImage(#imageLiteral(resourceName: "Group 6"), for: .normal)
        } else {
            setImage(#imageLiteral(resourceName: "Group 5"), for: .normal)
        }
    }
  
    
}
