//
//  ReviewCell.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/12/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var showMoreInfoBtn: UIButton!
    
    @IBOutlet weak var heightOfView: NSLayoutConstraint!
    var showMoreDidClicked: () -> () = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showMoreInfoBtn.addTarget(self, action: #selector(handleShowMore), for: .touchUpInside)
    }
    @objc func handleShowMore(){
        showMoreInfoBtn.isHidden = true
       
        showMoreDidClicked()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
