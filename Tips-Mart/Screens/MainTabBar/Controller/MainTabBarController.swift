//
//  MainTabBarController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/8/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    
      let mainVc = UIStoryboard(name: "MainPage", bundle: nil).instantiateViewController(withIdentifier: "MainPageVC") as! MainPageController
    override func viewDidLoad() {
        super.viewDidLoad()
        mainVc.tabBarItem = UITabBarItem(title: NSLocalizedString("Main", comment: ""), image: #imageLiteral(resourceName: "main"), tag: 0)
        
        viewControllers = [mainVc]
    }
    



}
