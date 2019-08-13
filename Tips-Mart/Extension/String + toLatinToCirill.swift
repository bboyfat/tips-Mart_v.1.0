//
//  String + toLatinToCirill.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/13/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation

extension String{
    
    func toLatinToCirill() -> [String]{
        guard let mutuableString = NSMutableString(utf8String: self) else {return []}
        guard let latinString = mutuableString.applyingTransform(StringTransform.toLatin, reverse: false) else {return []}
        guard let noDiacriticString = latinString.applyingTransform(StringTransform.stripDiacritics, reverse: false) else {return []}
        guard let kirillString = mutuableString.applyingTransform(StringTransform.latinToCyrillic, reverse: false) else {return []}
        guard let noDiacriticCirillString = kirillString.applyingTransform(StringTransform.stripDiacritics, reverse: false) else {return []}
        return  [noDiacriticString, noDiacriticCirillString]
    }
}
