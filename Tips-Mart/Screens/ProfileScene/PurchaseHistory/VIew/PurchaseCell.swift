//
//  PurchaseCell.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/17/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class PurchaseCell: UITableViewCell {

    @IBOutlet weak var cahsCurrency: UILabel!
    @IBOutlet weak var shopLogo: UIImageView!
    @IBOutlet weak var cashbackSum: UILabel!
    @IBOutlet weak var cashbackState: UILabel!
    @IBOutlet weak var createdTime: UILabel!
    @IBOutlet weak var operationID: UILabel!
    @IBOutlet weak var sumPurchaseLbl: UILabel!
    
    var currState: CurrencyState = .pending{
        didSet{
            switch self.currState {
        
            case .error:
                setStateColor(color: .orange, text: NSLocalizedString("err", comment: ""))
            case .cancelled:
                setStateColor(color: .red, text: NSLocalizedString("canceled", comment: ""))
            case .pending:
                setStateColor(color: #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1), text: NSLocalizedString("pending", comment: ""))
            case .credited:
                setStateColor(color: #colorLiteral(red: 0.0386101231, green: 0.8220543265, blue: 0.5023989081, alpha: 1), text: NSLocalizedString("credited", comment: ""))
                
            }
        }
    }
    var state: Int!{
        didSet{
            switch state {
            case -1:
                currState = .error
            case 1:
                currState = .cancelled
            case 21:
                currState = .pending
            case 22:
                currState = .credited
            default:
                currState = .pending
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setStateColor(color: UIColor, text: String){
        cashbackSum.textColor = color
        cahsCurrency.textColor = color
        cashbackState.textColor = color
        cashbackState.text = text
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
