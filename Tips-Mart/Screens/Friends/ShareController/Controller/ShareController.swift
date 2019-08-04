//
//  ShareController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/18/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ShareController: UIViewController {
    
    @IBOutlet var shareView: ShareVIew!
    
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "       ", with: .forceLeftToRight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: .white, with: NSLocalizedString("More Details", comment: ""))
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        setTitleColor(with: .white)
        
    }
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
    }
    @objc func handlePop(){
        navigationController?.popViewController(animated: true)
    }
    
}
