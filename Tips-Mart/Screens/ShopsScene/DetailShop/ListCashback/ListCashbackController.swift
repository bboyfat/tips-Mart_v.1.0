//
//  ListCashbackController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/10/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ListCashbackController: UIViewController {
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    var model: [ListCashBack] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ListCashbackController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "listCashCell", for: indexPath) as! ListCashbackCell
        let model = self.model[indexPath.row]
        
        cell.cashbackValue.text = String(model.value) + " " + model.typeCurrency
        cell.cashName.text = model.name.ru
        return cell
    }
    
    
}
extension ListCashbackController: UITableViewDelegate{
    
}
