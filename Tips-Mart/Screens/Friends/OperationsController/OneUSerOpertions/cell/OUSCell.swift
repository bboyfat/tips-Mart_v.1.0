//
//  OUSCell.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/22/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

enum CurrencyState{
    case error
    case cancelled
    case pending
    case credited
}


class OUSCell: UITableViewCell {
    @IBOutlet weak var yourBonusLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var operationIDLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var cahsBackValue: UILabel!
    var currState: CurrencyState = .pending{
        didSet{
            switch self.currState {
            case .error:
                setStateColor(color: .orange)
            case .cancelled:
                setStateColor(color: .red)
            case .pending:
                setStateColor(color: #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1))
            case .credited:
                setStateColor(color: #colorLiteral(red: 0.0386101231, green: 0.8220543265, blue: 0.5023989081, alpha: 1))
            
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
    private func setStateColor(color: UIColor){
        yourBonusLbl.textColor = color
        currencyLbl.textColor = color
        cahsBackValue.textColor = color
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
