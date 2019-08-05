//
//  CopyIDBtn.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class CopyIDBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(hndleCopy), for: .touchUpInside)
    }
    @objc func hndleCopy(){
        guard let id = userId() else {return}
        UIPasteboard.general.string = String(id)
    }

}
