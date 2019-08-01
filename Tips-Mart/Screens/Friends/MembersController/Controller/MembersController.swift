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
//        setClearNavigation(with: #colorLiteral(red: 0.1894809902, green: 0.7875444889, blue: 0.4261831641, alpha: 1), with: "Members")
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1894809902, green: 0.7875444889, blue: 0.4261831641, alpha: 1)
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membersCell", for: indexPath) as! MembersCell
        return cell
    }
    
    
}
extension MembersController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OUSVC") as! OUSContoller
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
