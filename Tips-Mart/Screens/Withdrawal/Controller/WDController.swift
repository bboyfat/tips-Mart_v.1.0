//
//  WDController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/23/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class WDController: UIViewController {
    
    @IBOutlet var wdView: WDView!
   let leftBarButtom = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "           ", with: .forceLeftToRight)
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        addNotifForKeyboard()
        wdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleEndEditing)))
    }
    @objc func handleEndEditing(){
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
    }
    
    func addNotifForKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(){
           self.view.bounds.origin.y = 30
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        
    
    @objc func keyboardWillHide(){
        //        self.view.frame = originalPosition
        self.view.bounds.origin.y = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    private func setNavigation(){
        setClearNavigation(with: .white, with: "WD")
        setTitleColor(with: .white)
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButtom))
    }
    private func addTarget(){
        leftBarButtom.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
    }
    
    
    @objc func handlePop(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}


