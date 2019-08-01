//
//  ProfileController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet var profileView: ProfileView!
    var balanceAlerts: BalanceAlerts!
    //MARK: Properties
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "        ", with: .forceLeftToRight)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Icon"), with: "", with: .forceRightToLeft)
    var model: RealmUserData!
    let networking = ProfileNetworkService()
    //StatusBar style
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        networking.sendRequest { (data) in
            OperationQueue.main.addOperation {
                self.setLabels(with: data)
            }
        }
        balanceAlerts = BalanceAlerts(controller: self)
        addTargets() // add targets fot items
        setViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: .white, with: "")
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        addRightButtonToNavigationBar(with: setItemForNavigationBar(button: rightBarButton))
    }
    
    //MARK: Methods
    
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
        rightBarButton.addTarget(self, action: #selector(handlePush), for: .touchUpInside)
    }
    @objc func handlePop(){
        self.dismiss(animated: true, completion: nil)
        
        
    }
    @objc func handlePush(){
        
    }
    private func setLabels(with model: ProfilesData?){
        guard let model = model else {return}
        profileView.membersLbl.text = "  " + String(model.referrals[0].members)
        profileView.invaitedLbl.text = "  " + String(model.referrals[1].members + model.referrals[2].members)
        profileView.bonusLbl.text = "  " + String(model.referrals[1].credited + model.referrals[2].credited) + " грн"
        profileView.totalCashback.text = "  " + String(
            model.referrals[0].credited + model.referrals[1].credited + model.referrals[2].credited) + " грн"
        profileView.operationsCountLbl.text = "  " + String(model.referrals[0].credited)
    }
    
    func setViews(){
        if let model = model{
            profileView.nicknameLabel.text = model.nickname
            profileView.idLabel.text = model.id.separate(every: 2, with: " ")
        }
    }
    //MARK: IBAction
    @IBAction func presentPurchaseHistory(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PurchaseVC") as! PurchaseHistoryController
        vc.purchaseSender = .profile
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func greenBalanceInfo(_ sender: UIButton) {
        balanceAlerts.presentInfo("Зеленый кошелек", BalanceAlertMessage.greenMessage.rawValue)
    }
    
    @IBAction func grayBalanceInfo(_ sender: Any) {
        balanceAlerts.presentInfo("Серый кошелек", BalanceAlertMessage.grayMessage.rawValue)
    }
    
    
}
