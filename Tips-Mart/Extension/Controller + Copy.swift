//
//  Controller + Copy.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

extension UIViewController{
    func copyToClipBoard(textToCopy: String) {
        UIPasteboard.general.string =   ""
        UIPasteboard.general.string = textToCopy
        
    }
}
