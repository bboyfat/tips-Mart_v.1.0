//
//  ShareVIew.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/18/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ShareVIew: UIView {
    @IBOutlet weak var inviteLbl: UILabel!
    @IBOutlet weak var scanLbl: UILabel!
    @IBOutlet weak var copyLbl: UILabel!
    @IBOutlet weak var shareLbl: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var linkTf: UITextField!
    @IBOutlet weak var invitingTerms: UILabel!
    
    @IBOutlet weak var qrImageVIew: UIImageView!
    @IBOutlet weak var linkView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setViews()
        setLink()
        linkView.layer.borderWidth = 1
        linkView.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        
    }
    func setViews(){
        inviteLbl.text = NSLocalizedString("invite", comment: "")
        scanLbl.text = NSLocalizedString("scan", comment: "")
        copyLbl.text = NSLocalizedString("copy", comment: "")
        shareLbl.text = NSLocalizedString("shareLbl", comment: "")
        invitingTerms.text = NSLocalizedString("invitingTerms", comment: "")
        shareBtn.setTitle(NSLocalizedString("shareBtn", comment: ""), for: .normal)
    }
    func setLink(){
        guard let id = userId() else {return}
        self.linkTf.text = "https://tips-mart.com?r=\(id)"
        qrImageVIew.image = BarCodeGenerator().generateBrCode(qrOrBar: .QRCode, from: self.linkTf.text!)
    }
    
}
