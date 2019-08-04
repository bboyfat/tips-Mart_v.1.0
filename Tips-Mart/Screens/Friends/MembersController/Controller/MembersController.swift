//
//  MembersController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/19/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class MembersController: UIViewController {
    
    
    //MARK: Properties
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "    ", with: .forceLeftToRight)
    let nib = UINib(nibName: "MembersCell", bundle: nil)
    var model: [MembersData] = []{
        didSet{
            self.tableView.reloadData()
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
        setTitleColor(with: .black)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1894809902, green: 0.7875444889, blue: 0.4261831641, alpha: 1)
        navigationItem.title = "Members"
        MembersNetworkService().sendRequest { (members) in
            if let member = members{
                self.model = member
            }
        }
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
    }
    //MARK: Methods
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
    }
    @objc func handlePop(){
       navigationController?.popViewController(animated: true)
        
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
        cell.friendsBonusGray.text = String(model.profitFromLines.grayBalance)
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
}
