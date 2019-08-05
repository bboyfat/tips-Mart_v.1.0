//
//  OUSContoller.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/22/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class OUSContoller: UIViewController {
    
    @IBOutlet weak var nickNameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var requestModel: OUSRequest!
    let net =  OUSNetworkService()
    var usersNickName: String = ""
    var model: [OUSData] = []
    
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "    ", with: .forceLeftToRight)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "fillter"), with: "", with: .unspecified)
    let nib = UINib(nibName: "OUSCell", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(nib, forCellReuseIdentifier: "ousCell")
        tableView.delegate = self
        tableView.dataSource = self
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nickNameLbl.text = usersNickName
        net.model = requestModel
        net.sendRequest {[unowned self] (data) in
            if let data = data{
                self.model = data
                self.reload()
            }
        }
        setNavigation()
    }
    
    private func reload(){
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    private func setNavigation(){
        setClearNavigation(with: .white, with: NSLocalizedString("User's operations", comment: ""))
        setTitleColor(with: .white)
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        addRightButtonToNavigationBar(with: setItemForNavigationBar(button: rightBarButton))
    }
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
        rightBarButton.addTarget(self, action: #selector(handleShowFilters), for: .touchUpInside)
    }
    @objc func handlePop(){
        self.navigationController?.popViewController(animated: true)
        
    }
    @objc func handleShowFilters(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "OperationFilterVC") as! OperationFilterController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension OUSContoller: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ousCell", for: indexPath) as! OUSCell
        let model = self.model[indexPath.row]
        setCell(cell: cell, with: model)
        return cell
    }
    func setCell(cell: OUSCell, with model: OUSData){
        cell.cahsBackValue.text = String(model.userCashback)
        cell.operationIDLbl.text = model.cashbackID
        cell.state = model.status
        let date = Date(timeIntervalSinceReferenceDate: Double(model.created))
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        cell.dateLbl.text = myStringafd
    }
    
    
}

extension OUSContoller: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = model.count - 1
        if indexPath.row == lastItem{
            loadMoreData()
        }
    }
    
    func loadMoreData(){
        
        net.model = OUSRequest(_user: requestModel._user, statuses: nil, createdFrom: nil, createdTo: model.last?.created)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzzZ"
        //        let date = dateFormatter.date(from: isoDate!)
    
        net.sendRequest{ (modelNet) in
            let newMOdel = modelNet!.filter(){ [unowned self] in
                let newMode = self.model.map({ (data) -> String in
                    return data.cashbackID
                })
                return !newMode.contains($0.cashbackID)
            }
            self.model.append(contentsOf: newMOdel)
            if !newMOdel.isEmpty {
                self.reload()
            }
            
        }
    }
}
