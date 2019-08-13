//
//  MembersController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/19/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class MembersController: UIViewController {
    
    @IBOutlet weak var isEmptyView: UIView!
    
    @IBOutlet weak var isEmptyLbl: UILabel!
    //MARK: Properties
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "    ", with: .forceLeftToRight)
    let nib = UINib(nibName: "MembersCell", bundle: nil)
    var model: [MembersData] = []{
        didSet{
            emptyMembersPopUp()
//            self.tableView.reloadData()
        }
    }
    //MARK: Lyficycle
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(nib, forCellReuseIdentifier: "membersCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isEmptyLbl != nil{
        isEmptyLbl.text = NSLocalizedString("empty", comment: "")
        }
        setTitleColor(with: .black)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1894809902, green: 0.7875444889, blue: 0.4261831641, alpha: 1)
        navigationItem.title = NSLocalizedString("members", comment: "")
        MembersNetworkService(model: MembersRequest(lastCreated: nil)).sendRequest { (members) in
            if let member = members{
                
                self.model = member
                self.reload()
               
            }
        }
        
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
    }
    //MARK: Methods
    func emptyMembersPopUp(){
        if !self.model.isEmpty{
            if isEmptyView != nil{
            isEmptyView.removeFromSuperview()
            }
        }
    }
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
    }
    @objc func handlePop(){
       navigationController?.popViewController(animated: true)
        
    }
    private func reload(){
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    
   
    
}


extension MembersController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func setCell(cell: MembersCell, with model: MembersData){
        cell.nicknameLbl.text = model.nickname
        cell.ifLbl.text = String(model.userid)
        cell.operationsLbl.text = String(model.countOperations)
        cell.friendsBonusGreen.text = String(model.profitFromFriend.greenBalance)
        cell.friendsBonusGray.text = String(model.profitFromFriend.grayBalance)
        cell.familiarsBponusGreen.text = String(model.profitFromLines.greenBalance)
        cell.familirsBonusGray.text = String(model.profitFromLines.grayBalance)
        cell.familiarsCount.text = String(model.invitedMembers.first ?? 0)
        cell.strangersCount.text = String(model.invitedMembers.last ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membersCell", for: indexPath) as! MembersCell
        let model = self.model[indexPath.row]
        setCell(cell: cell, with: model)
        return cell
    }
    
    
}
extension MembersController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.model[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "OUSVC") as! OUSContoller
        vc.requestModel = OUSRequest(_user: model._user, statuses: nil, createdFrom: nil, createdTo: nil)
        vc.usersNickName = model.nickname
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = self.model.count - 1
        if indexPath.row == lastItem{
            loadMoreData()
        }
        
    }
    func loadMoreData(){
        let created = self.model.last?.created
        let memersLastCreated = MembersRequest(lastCreated: created!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzzZ"
        //        let date = dateFormatter.date(from: isoDate!)
        MembersNetworkService(model: memersLastCreated).sendRequest { (membaers) in
            let newMOdel = membaers!.filter(){ [unowned self] in
                let newMode = self.model.map({ (data) -> String in
                    return data._user
                })
                return !newMode.contains($0._user)
            }
                self.model.append(contentsOf: newMOdel)
                if !newMOdel.isEmpty {
                    self.reload()
                }
            }
        
       
    }
}
