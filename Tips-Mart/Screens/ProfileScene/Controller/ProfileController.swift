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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUsersData()
        setClearNavigation(with: .white, with: "")
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        addRightButtonToNavigationBar(with: setItemForNavigationBar(button: rightBarButton))
    }
    
    //MARK: Methods
    private func setUsersData(){
        guard let nick = nickname() else { return}
        guard let id = userId() else {return}
        guard let greenBalance = greenBalance() else {return}
        guard let grayBalance = grayBalance() else {return}
        self.profileView.nicknameLabel.text = nick
        self.profileView.greenBalance.text = String(greenBalance) + " " + NSLocalizedString("uah", comment: "")
        self.profileView.grayBalance.text = String(grayBalance) + " " + NSLocalizedString("uah", comment: "")
        self.profileView.idLabel.text = String(id).separate(every: 2, with: " ")
    }
    
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
    
    
    //MARK: IBAction
    @IBAction func presentPurchaseHistory(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PurchaseVC") as! PurchaseHistoryController
        vc.purchaseSender = .profile
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func editProfile(_ sender: UIButton) {
        let vc = UIStoryboard(name: "EditProfile", bundle: nil).instantiateViewController(withIdentifier: "EditProfileScreen") as! EditProfileController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .pageSheet
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func greenBalanceInfo(_ sender: UIButton) {
        balanceAlerts.presentInfo("Зеленый кошелек", BalanceAlertMessage.greenMessage.rawValue)
    }
    
    @IBAction func grayBalanceInfo(_ sender: Any) {
        balanceAlerts.presentInfo("Серый кошелек", BalanceAlertMessage.grayMessage.rawValue)
    }
    
    
}
