//
//  RealmRegViewModel.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import RealmSwift

protocol RealmServiceProtocol: class {
    func fetch() -> RealmUserData?
    func save()
    var userData: UsersData{ get set}
    func update()
    func delete()
}

class RealmService: RealmServiceProtocol{
    
    //User data to convert it to realmObject
    var userData: UsersData
    //fetch data method
    func fetch() -> RealmUserData? {
        var fetchedData: RealmUserData?
        let realm = try! Realm()
        let result = realm.objects(RealmUserData.self)
        fetchedData = result.last
        return fetchedData
    }
    //save data method
    func save() {
        let userDataRealm = RealmUserData()
        userDataRealm.setValue(userData.name, forKey: "name")
        userDataRealm.setValue(userData.phoneNumber, forKey: "phoneNumber")
        userDataRealm.setValue(userData.surname, forKey: "surName")
        let idString = String(userData.userid)
        userDataRealm.setValue(idString, forKey: "id")
        
        let realm = try! Realm()
        
        do{
            try realm.write {
                realm.add(userDataRealm)
            }
        } catch let realmErr {
            print("can't save", realmErr)
        }
        
    }
    
    func update() {
        
    }
    
    func delete() {
        
    }
    
    
    init(userData: UsersData) {
        self.userData = userData
    }
    
    
    
    
    
}
