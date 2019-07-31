//
//  String + Separate.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/26/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

extension String {
    func separate(every stride: Int, with separator: Character) -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
}
