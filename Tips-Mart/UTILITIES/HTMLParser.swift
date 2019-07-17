//
//  HTMLParser.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/16/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
import SwiftSoup

class HTMLParser{
    
    func parseHTML(htmlContent: String) -> String{
        
        do{
            let doc = try parse(htmlContent)
            let element = try doc.select("body").first()
            let textBody = try element?.text()
            guard let text = textBody else { return "OOPS"}
            return text
        } catch {
            fatalError("Problem with HTML doc")
        }
        
    }
    
}


