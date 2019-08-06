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
      let shopsVc = UIStoryboard(name: "ShopsScene", bundle: nil).instantiateViewController(withIdentifier: "ShopsVC") as! ShopsController
    let friendsVC = UIStoryboard(name: "Friends", bundle: nil).instantiateViewController(withIdentifier: "friendsNavVC")
    let moreScreen = UIStoryboard(name: "More", bundle: nil).instantiateViewController(withIdentifier: "MoreNavigation") 
    override func viewDidLoad() {
        super.viewDidLoad()
        let shonNav = UINavigationController(rootViewController: shopsVc)
        reloadBalance()
        mainVc.tabBarItem = UITabBarItem(title: NSLocalizedString("Main", comment: ""), image: #imageLiteral(resourceName: "main"), tag: 0)
        shonNav.tabBarItem = UITabBarItem(title: NSLocalizedString("Shops", comment: ""), image: #imageLiteral(resourceName: "Shops"), tag: 1)
        friendsVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Friends", comment: ""), image: #imageLiteral(resourceName: "friendsBar"), tag: 2)
        moreScreen.tabBarItem = UITabBarItem(title: NSLocalizedString("More", comment: ""), image: #imageLiteral(resourceName: "moreIcon"), tag: 3)
        viewControllers = [mainVc, shonNav, friendsVC, moreScreen]
    }
    
    private func reloadBalance(){
        BalanceNetworkService().sendRequest { (finish) in
        
        }
    }



}
