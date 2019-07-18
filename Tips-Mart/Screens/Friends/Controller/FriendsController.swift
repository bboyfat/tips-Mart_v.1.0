//
//  FriendsController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/18/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class FriendsController: UIViewController {
    //MARK: Properties
    @IBOutlet var friendsView: FriendsView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = attributes
        friendsView.moreDetailsPressed = {[weak self] in
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "MoreDetailsVC") as! AboutCashController
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func inviteBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShareVC") as! ShareController
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
}
