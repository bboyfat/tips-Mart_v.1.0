//
//  Array + Remove.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/11/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//


import Foundation


extension Array where Element: Equatable{
    mutating func remove(_ element: Element) {
        _ = firstIndex(of: element).flatMap {
            self.remove(at: $0)
        }
    }
}
