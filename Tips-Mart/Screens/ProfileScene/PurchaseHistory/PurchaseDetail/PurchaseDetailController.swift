//
//  PurchaseDetailController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/17/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class PurchaseDetailController: UIViewController {
    
    //MARK: Properties
    var model: PurchaseObject!
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: " Назад", with: .forceLeftToRight)
    
    @IBOutlet var purchaseDetailView: PurchaseDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        if model != nil{
            setLabels(model: model)
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: #colorLiteral(red: 0.0386101231, green: 0.8220543265, blue: 0.5023989081, alpha: 1), with: NSLocalizedString("Detail", comment: ""))
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        
    }
    
    
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
    }
    @objc func handlePop(){
        navigationController?.popViewController(animated: true)
    }
    private func setStateColor(color: UIColor){
        purchaseDetailView.operationState.textColor = color
    }
    private func setLabels(model: PurchaseObject){
        purchaseDetailView.operationID.text = model.cashbackID
        let stateString = {[unowned self] () -> String in
            switch model.status {
            case -1:
                self.setStateColor(color: .red)
                return NSLocalizedString("err", comment: "")
            case 1:
                self.setStateColor(color: .orange)
                return NSLocalizedString("canceled", comment: "")
            case 21:
                self.setStateColor(color: #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1))
                return NSLocalizedString("pending", comment: "")
            case 22:
                self.setStateColor(color: #colorLiteral(red: 0.0386101231, green: 0.8220543265, blue: 0.5023989081, alpha: 1))
                return NSLocalizedString("credited", comment: "")
                
            default:
                return "   "
            }}()
            
        purchaseDetailView.operationState.text = stateString
        purchaseDetailView.shopNameLbl.text = model.shopData.name
        purchaseDetailView.sumPurchaseLbl.text = String(model.sumPurchase)
        purchaseDetailView.cashbackSum.text = String(model.userCashback)
        purchaseDetailView.createdLbl.text = stringToDateToString(date: model.created) 
        purchaseDetailView.updatedLbl.text = stringToDateToString(date: model.updated) 
    }
    private func stringToDateToString(date string: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzzZ"
        let date = dateFormatter.date(from: string)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let stringDate = dateFormatter.string(from: date!)
        return stringDate
    }
   
    
}
