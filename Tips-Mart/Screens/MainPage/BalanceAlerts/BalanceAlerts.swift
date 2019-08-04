//
//  BalanceAlerts.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/31/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

enum BalanceAlertMessage: String{
    case greenMessage = "Сумма кэшбэка за покупки, которая зачисленна на ваш баланс."
    case grayMessage = "Сумма кэшбэка, которая будет доступна после подтверждения вашей покупки магазином."
}

class BalanceAlerts{
    var controller: UIViewController!
    
    func presentInfo(_ title: String, _ message: BalanceAlertMessage.RawValue){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Принять", style: .cancel, handler: nil)
        
        ac.view.tintColor = #colorLiteral(red: 0.1137254902, green: 0.8, blue: 0.4274509804, alpha: 1)
        ac.addAction(action)
        controller.present(ac, animated: true, completion: nil)
    }
    func presentUpdateAlert(){
        let ac = UIAlertController(title: "ОБНОВЛЕНИЕ", message: "Следите за обновлениям, совсем скоро данная возможность будет доступна", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(action)
        controller.present(ac, animated: true, completion: nil)
    }
    init(controller: UIViewController) {
        self.controller = controller
    }
}
