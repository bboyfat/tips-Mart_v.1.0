//
//  CustomAlertController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/17/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class PurchaseAlertController: UIViewController {

    var detailsDidTapped: () -> () = {}
    var toChallengeDidTapped: () -> () = {}
    var deleteDidTapped: () -> () = {}
    var archiveDidTapped: () -> () = {}
    
    
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var toChallengeView: UIView!
    @IBOutlet weak var deleteView: UIView!
    
    @IBOutlet weak var archiveVIew: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       addTapGetures()
        
    }
    
    func addTapGetures(){
        cancelView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancel)))
        detailsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDetails)))
        toChallengeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChallenge)))
        deleteView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDelete)))
        archiveVIew.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleArchive)))
    }
    
    
    @objc func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func handleDelete(){
        deleteDidTapped()
    }
    @objc func handleChallenge(){
        toChallengeDidTapped()
    }
    @objc func handleArchive(){
        archiveDidTapped()
    }
    @objc func handleDetails(){
        detailsDidTapped()
    }

}
