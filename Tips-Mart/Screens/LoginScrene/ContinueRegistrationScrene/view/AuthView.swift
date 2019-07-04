//
//  AuthView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/4/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class AuthView: UIView {

    @IBOutlet weak var authTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        setPlaceHolder()
    }
    private func setPlaceHolder(){
        authTextField.attributedPlaceholder = NSAttributedString(string: "Код", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
