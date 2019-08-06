//
//  Data + Token.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/6/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
