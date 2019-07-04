//
//  NavigationItem + Item.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/4/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

extension UINavigationItem{
    
    static  func setTheBUtton(with image: UIImage, with title: String, with attribute: UISemanticContentAttribute) -> UIButton{
        let view = UIView()
        let button = UIButton(type: .system)
        button.semanticContentAttribute = attribute
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        view.addSubview(button)
        view.frame = button.bounds
 
        return button
        
        
    }
}
