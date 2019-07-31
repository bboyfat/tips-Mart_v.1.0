//
//  MainPageViewModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/26/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import RxRealm
import RealmSwift
import RxSwift

protocol MainUserInfoProtocol{
    func getModel() -> RealmUserData
}
protocol ObservableMainUserInfoProtocol{
    
    func getRealmModel(handler: (Results<RealmUserData>)->())
}



class ObservableInfo: NSObject, ObservableMainUserInfoProtocol{
    
    func getRealmModel(handler: (Results<RealmUserData>)->()){
        
        do{
            let realm = try Realm()
            handler(realm.objects(RealmUserData.self))
        } catch{
            print(getRealmModel)
        }
        
    }
    
    override init() {
        super.init()
        
    }
}

class MainPageViewModel: MainUserInfoProtocol{
   
    var model: RealmUserData!
    var bag = DisposeBag()
    var observableInfo: ObservableMainUserInfoProtocol!
    var realmService: RealmServiceProtocol!
    var infoUpdated: () -> () = {}
    func getModel() -> RealmUserData{
        return self.model
    }
    func fetchData(){
        _ = self.observableInfo.getRealmModel(handler: { (result) in
            Observable.collection(from: result).subscribe(onNext: {[weak self](info) in
                self?.model = Array(info).last
                self?.infoUpdated()
            }).disposed(by: bag)
            
        })
    }
    
    init() {
        observableInfo = ObservableInfo()
        fetchData()
        
    }
}
