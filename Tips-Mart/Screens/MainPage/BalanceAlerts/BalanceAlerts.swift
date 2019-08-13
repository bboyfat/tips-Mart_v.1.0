//
//  BalanceAlerts.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/31/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

enum BalanceAlertMessage: String{
    case greenMessage = "greenWalletInfo"
    case grayMessage = "grayWalletInfo"
    case wdCard = "wdRulesCard"
    case wdPhone = "wdrulesPhone"
}

class BalanceAlerts{
    var controller: UIViewController!
    
    func presentInfo(_ title: String, _ message: BalanceAlertMessage.RawValue, dismissOnEnd: Bool){
        let ac = UIAlertController(title: title, message: NSLocalizedString(message, comment: ""), preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .cancel) { (_) in
            if dismissOnEnd{
                self.controller.dismiss(animated: true, completion: nil)
            }
        }
        
        ac.view.tintColor = #colorLiteral(red: 0.1137254902, green: 0.8, blue: 0.4274509804, alpha: 1)
        ac.addAction(action)
        controller.present(ac, animated: true, completion: nil)
    }
    func presentUpdateAlert(){
        let ac = UIAlertController(title: NSLocalizedString("yourAttention", comment: ""), message: NSLocalizedString("checkUpdate", comment: ""), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(action)
        controller.present(ac, animated: true, completion: nil)
    }
    
    
    init(controller: UIViewController) {
        self.controller = controller
    }
}
