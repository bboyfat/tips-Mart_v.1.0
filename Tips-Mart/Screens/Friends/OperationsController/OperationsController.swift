//
//  OperationsController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/22/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class OperationsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "    ", with: .forceLeftToRight)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "fillter"), with: "", with: .unspecified)
    let nib = UINib(nibName: "OperationsCell", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(nib, forCellReuseIdentifier: "operationCell")
        tableView.dataSource = self
        tableView.delegate = self
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: .white, with: "Operations")
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


extension OperationsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "operationCell", for: indexPath) as! OperationsCell
        return cell
    }
    
    
}

extension OperationsController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OUSVC") as! OUSContoller
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
