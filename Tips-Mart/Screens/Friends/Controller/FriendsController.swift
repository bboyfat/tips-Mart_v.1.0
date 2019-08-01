//
//  FriendsController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/18/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class FriendsController: UIViewController {
    //MARK: Properties
    @IBOutlet var friendsView: FriendsView!
    var statisticController: StatisticControllerProtocol!
    var nav: UINavigationController!
    let networkService = FriendsNetworkService()
    
    var modelArray = [Referals]()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statisticController = storyboard?.instantiateViewController(withIdentifier: "StatVC") as! StatisticController
        nav = UINavigationController(rootViewController: statisticController as! StatisticController)
        networkService.sendRequest { (data) in
            self.modelArray = data ?? []
            self.statisticController.modelArray = self.modelArray
            OperationQueue.main.addOperation {
                self.funcSetBtnlbls()
            }
        }
        showMoreDetailsClosure()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTitleColor(with: .black)
    }
    
    //MARK: Methods
    private func showMoreDetailsClosure(){
        friendsView.moreDetailsPressed = {[weak self] in
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "MoreDetailsVC") as! AboutCashController
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func funcSetBtnlbls(){
       friendsView.friendsBtnOutlet.setTitle(String(modelArray[0].members) + " " + peopleCount, for: .normal)
        friendsView.familiarsBtnOutlet.setTitle(String(modelArray[1].members) + " " + peopleCount, for: .normal)
        friendsView.strangersBtnOutlet.setTitle(String(modelArray[2].members) + " " + peopleCount, for: .normal)
        friendsView.totalBonusBtnLbl.text = String(modelArray[0].credited + modelArray[1].credited + modelArray[2].credited) + " " + currency
    }
    
    @IBAction func inviteBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShareVC") as! ShareController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func friendsStatAction(_ sender: UIButton) {
        self.statisticController.modelArray = modelArray
        navigationController?.present(self.nav, animated: true, completion: {
            self.statisticController.statisticFor = .friends
        })
    }
    
    @IBAction func familiarStatAction(_ sender: Any) {
        statisticController.modelArray = self.modelArray
        navigationController?.present(nav, animated: true, completion: {
            self.statisticController.statisticFor = .familiars
        })
    }
    @IBAction func strangerStatAction(_ sender: Any) {
        statisticController.modelArray = self.modelArray
        navigationController?.present(nav, animated: true, completion: {
            self.statisticController.statisticFor = .strangers
        })
    }
}
