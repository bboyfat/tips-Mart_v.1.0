//
//  PurchaseDSD.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/17/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class PurchaseDSD: NSObject, UITableViewDataSource{
    
    var tableView: UITableView!
    var controller: UIViewController!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as! PurchaseCell
        return cell
    }
    
    init(tableView: UITableView, controller: UIViewController) {
        self.tableView = tableView
        self.controller = controller
        let nib = UINib(nibName: "PurchaseCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "purchaseCell")
    }
}


extension PurchaseDSD: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let purchaseDetail = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "PurchaseDetail") as! PurchaseDetailController
      let ac = PurchaseAlertController()
        ac.modalPresentationStyle = .overCurrentContext
        ac.detailsDidTapped = {[weak self] in
            ac.dismiss(animated: true, completion: nil)
            self?.controller.navigationController?.pushViewController(purchaseDetail, animated: true)
            
        }
        ac.deleteDidTapped = {print("delete")}
        ac.toChallengeDidTapped = {print("challenge")}
        ac.archiveDidTapped = {print("archive")}
        controller.present(ac, animated: true, completion: nil)
    }
}
