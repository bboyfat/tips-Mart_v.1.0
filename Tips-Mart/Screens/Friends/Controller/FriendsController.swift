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
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        statisticController = storyboard?.instantiateViewController(withIdentifier: "StatVC") as! StatisticController
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
    @IBAction func inviteBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShareVC") as! ShareController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func friendsStatAction(_ sender: UIButton) {
        let nav = UINavigationController(rootViewController: statisticController as! StatisticController)
        navigationController?.present(nav, animated: true, completion: {
            self.statisticController.statisticFor = .friends
        })
    }
    
    @IBAction func familiarStatAction(_ sender: Any) {
        let nav = UINavigationController(rootViewController: statisticController as! StatisticController)
        navigationController?.present(nav, animated: true, completion: {
            self.statisticController.statisticFor = .familiars
        })
    }
    @IBAction func strangerStatAction(_ sender: Any) {
        let nav = UINavigationController(rootViewController: statisticController as! StatisticController)
        navigationController?.present(nav, animated: true, completion: {
            self.statisticController.statisticFor = .strangers
        })
    }
}
