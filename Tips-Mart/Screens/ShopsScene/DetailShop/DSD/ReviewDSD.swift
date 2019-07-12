//
//  ReviewDSD.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/12/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ReviewDSD: NSObject, UITableViewDataSource{
    
    var tavleView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        return cell
    }
    init(tableView: UITableView) {
        
        self.tavleView = tableView
        let nibName = UINib(nibName: "ReviewCell", bundle: nil)
        self.tavleView.register(nibName, forCellReuseIdentifier: "reviewCell")
    }
    
}


extension ReviewDSD: UITableViewDelegate{
    
}
