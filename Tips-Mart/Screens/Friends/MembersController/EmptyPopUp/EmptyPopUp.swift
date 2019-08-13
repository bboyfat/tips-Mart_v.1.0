//
//  EmptyPopUp.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/8/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class EmptyPopUp {
    var controller: UIViewController!
    func emptyMembersPopUp(){
        let ac = UIAlertController(title: NSLocalizedString("yourAttention", comment: ""), message: NSLocalizedString("memersIsEmpty", comment: ""), preferredStyle: .actionSheet)
        let invite = UIAlertAction(title: NSLocalizedString("invite", comment: ""), style: .cancel) { (_) in
            self.presentShareController()
        }
        let inviteLater = UIAlertAction(title: NSLocalizedString("later", comment: ""), style: .default) { (_) in
            self.controller.dismiss(animated: true, completion: nil)
        }
        ac.view.tintColor = #colorLiteral(red: 0.1137254902, green: 0.8, blue: 0.4274509804, alpha: 1)
        ac.addAction(invite)
        ac.addAction(inviteLater)
        controller.present(ac, animated: true, completion: nil)
    }
    func emptyPurchasePopUp(){
        let ac = UIAlertController(title: NSLocalizedString("yourAttention", comment: ""), message: NSLocalizedString("purchaseEmpty", comment: ""), preferredStyle: .actionSheet)
        let goShopping = UIAlertAction(title: NSLocalizedString("goToShop", comment: ""), style: .cancel) { (_) in
            self.presentShops()
        }
        let buyLater = UIAlertAction(title: NSLocalizedString("later", comment: ""), style: .default) { (_) in
            self.controller.dismiss(animated: true, completion: nil)
        }
        ac.view.tintColor = #colorLiteral(red: 0.1137254902, green: 0.8, blue: 0.4274509804, alpha: 1)
        ac.addAction(goShopping)
        ac.addAction(buyLater)
        controller.present(ac, animated: true) {
            
        }
        
    }
    
    func presentShareController(){
        
        let vc = UIStoryboard(name: "Friends", bundle: nil).instantiateViewController(withIdentifier: "ShareVC") as! ShareController
        vc.senderIs = .popUp
        let nav = UINavigationController(rootViewController: vc)
        OperationQueue.main.addOperation {
            self.controller.present(nav, animated: true) {
            }
        }
        
    }
    
    func presentShops(){
        let shopsVc = UIStoryboard(name: "ShopsScene", bundle: nil).instantiateViewController(withIdentifier: "ShopsVC") as! ShopsController
        let nav = UINavigationController(rootViewController: shopsVc)
        shopsVc.modalPresentationStyle = .overFullScreen
        shopsVc.addRightButton()
        shopsVc.senderIs = .search
        OperationQueue.main.addOperation {
            self.controller.present(nav, animated: true) {
                shopsVc.addSwipe()
            }
        }
        
    }
    
    init(controller: UIViewController) {
        self.controller = controller
    }
}
