//
//  UIViewController + ClearNavigation.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/19/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
// extension for clear navigation controller, to set the clear and cool background
extension UIViewController{
    
    func setClearNavigation(with tintColor: UIColor, with title: String){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.title = title
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func addRightButtonToNavigationBar(with view: UIView){
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
    }
    func addLeftButtonToNavigationBar(with view: UIView){
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
    }
    func setItemForNavigationBar(button: UIButton) -> UIView{
        let view = UIView()
        view.addSubview(button)
        view.frame = button.bounds
        return view
    }
    func setTitleColor(with color: UIColor){
        let attributes = [NSAttributedString.Key.foregroundColor : color]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
}
