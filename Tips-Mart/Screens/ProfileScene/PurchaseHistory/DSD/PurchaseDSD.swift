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
    var viewModel: PurchaseViewModel!
    var model: [PurchaseObject]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as! PurchaseCell
        let model = self.model[indexPath.row]
        
        cell.sumPurchaseLbl.text = NSLocalizedString("Transaction amount", comment: "") + " " + String(model.sumPurchase)
        cell.createdTime.text = model.created
        cell.operationID.text = NSLocalizedString("Operation ID", comment: "") + " " + model.cashbackID
        cell.cashbackSum.text = String(model.userCashback)
        
        LogoNetworkService().getImages(with: model.shopData.pathToImage) { (image) in
            OperationQueue.main.addOperation {
                cell.shopLogo.image = image
            }
        }
        return cell
    }
    
    init(tableView: UITableView, controller: UIViewController, model: [PurchaseObject]) {
        self.model = model
        self.tableView = tableView
        self.controller = controller
        let nib = UINib(nibName: "PurchaseCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "purchaseCell")
        viewModel = PurchaseViewModel()
        self.tableView.reloadData()
    }
}


extension PurchaseDSD: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let purchaseDetail = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "PurchaseDetail") as! PurchaseDetailController
      let ac = PurchaseAlertController()
        ac.modalPresentationStyle = .overCurrentContext
        ac.detailsDidTapped = {[weak self] in
            ac.dismiss(animated: true, completion: nil)
            purchaseDetail.model = self?.model[indexPath.row]
            self?.controller.navigationController?.pushViewController(purchaseDetail, animated: true)
            
        }
        ac.deleteDidTapped = {print("delete")}
        ac.toChallengeDidTapped = {print("challenge")}
        ac.archiveDidTapped = {print("archive")}
        controller.present(ac, animated: true, completion: nil)
    }
}
