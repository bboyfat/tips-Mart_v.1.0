//
//  InternetErrors.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/6/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class InternetAlert{
    func tokenisEmpytAlert(controller: UIViewController){
        let ac = UIAlertController(title: NSLocalizedString("warning", comment: ""), message: NSLocalizedString("needInternet", comment: ""), preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .cancel) { (_) in
            
        }
        ac.addAction(action)
        controller.present(ac, animated: true, completion: nil)
    }
    func tokenisNotEmpytAlert(controller: UIViewController){
        let ac = UIAlertController(title: NSLocalizedString("warning", comment: ""), message: NSLocalizedString("fullServcie", comment: ""), preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .cancel) { (_) in
            self.presentBarCode(controller: controller)
        }
        ac.addAction(action)
        
        controller.present(ac, animated: true, completion: nil)
    }
    func presentBarCode(controller: UIViewController){
        OperationQueue.main.addOperation {
            let vc = UIStoryboard(name: "MyCard", bundle: nil).instantiateViewController(withIdentifier: "MyCardVC") as! MyCardController
           
            controller.present(vc, animated: true, completion: {
            })
        }
        
    }
    
}
