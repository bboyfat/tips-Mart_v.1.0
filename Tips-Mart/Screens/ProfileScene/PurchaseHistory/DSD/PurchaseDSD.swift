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
    var changeStateService = PurchaseStateService() // object tha send requests to remove or archived purchases
    var model: [PurchaseObject]{
        didSet{
            print(model.count)
        }
    }
    
    
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = model.count - 1
        if indexPath.row == lastItem{
            loadMoreData()
        }
    }
    
    func loadMoreData(){
        let isoDate = model.last?.created
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzzZ"
        let date = dateFormatter.date(from: isoDate!)
        
        PurchaseHistoryNetworking().sendRequest(with:PurchaseReqData(data: PurchaseReq(statuses: nil, isArchived: nil, createdFrom: nil, createdTo: Int((date?.timeIntervalSince1970)!))) ) { (modelNet) in
            for i in 0..<modelNet.count{
                print(modelNet[i])
                if self.model.last?._purchase != modelNet[i]._purchase{
                    self.model.append(modelNet[i])
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                }
            }
            
        }
    }
    
}


extension PurchaseDSD: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let purchaseDetail = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "PurchaseDetail") as! PurchaseDetailController
        let ac = PurchaseAlertController()
        let model = self.model[indexPath.row]
        ac.modalPresentationStyle = .overCurrentContext
        ac.detailsDidTapped = {[weak self] in
            ac.dismiss(animated: true, completion: nil)
            purchaseDetail.model = model
            self?.controller.navigationController?.pushViewController(purchaseDetail, animated: true)
            
        }
        ac.deleteDidTapped = {[weak self] in
            self?.changeStateService.sendRequest(with: PurchaseStateModel(newState: [PurchaseState.remove.rawValue], _purchase: model._purchase), handler: { (_) in
                
            })
//            self?.model.remove(model)
//            self?.tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: .bottom)
        }
        ac.toChallengeDidTapped = {print("challenge")}
        ac.archiveDidTapped = {[weak self] in
            self?.changeStateService.sendRequest(with: PurchaseStateModel(newState: [PurchaseState.archive.rawValue], _purchase: model._purchase), handler: { (_) in
                
            })}
        controller.present(ac, animated: true, completion: nil)
    }
    
}


