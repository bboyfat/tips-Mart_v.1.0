//
//  DetailShopController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/12/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class DetailShopController: UIViewController {
    var dataSourceDelegate: ReviewDSD!
    @IBOutlet weak var reviewTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSourceDelegate = ReviewDSD(tableView: reviewTableView)
        reviewTableView.dataSource = dataSourceDelegate
        reviewTableView.delegate = dataSourceDelegate
        
    }
    

   

}
