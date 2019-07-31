//
//  PurchaseViewModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/24/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation
protocol PurchaseViewModelProtocol {
    func itemsCount() -> Int
    func getData(with indexPath: IndexPath) -> PurchaseObject
}

class PurchaseViewModel: PurchaseViewModelProtocol {
    var model: [PurchaseObject]!
    
    func itemsCount() -> Int{
        return model.count
    }
    func getArray(){
        PurchaseHistoryNetworking().sendRequest(with: PurchaseReqData(data: PurchaseReq())) { (model) in
            self.model = model
        }
    }
    func getData(with indexPath: IndexPath) -> PurchaseObject{
        return model[indexPath.row]
    }
    
    
    init() {
       getArray()
    }
}
