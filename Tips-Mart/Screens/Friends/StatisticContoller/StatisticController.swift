//
//  StatisticController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/19/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

enum StatisticFor{
    case friends
    case familiars
    case strangers
}

protocol StatisticControllerProtocol: class{
    var statisticFor: StatisticFor { get set }
    var modelArray: [Referals] {get set}
}

class StatisticController: UIViewController, StatisticControllerProtocol {
    
    //MARK: Properties
    
    @IBOutlet var statisticView: StatisticView!
    var modelArray = [Referals]()
    var statisticFor: StatisticFor = .strangers{
        didSet{
            statisticForChenged()
        }
    }
    
    
    
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: " Назад", with: .forceLeftToRight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: #colorLiteral(red: 0.1894809902, green: 0.7875444889, blue: 0.4261831641, alpha: 1), with: "Bonuses")
        setTitleColor(with: .black)
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
    }
    
    
    private func statisticForChenged(){
        switch statisticFor {
        case .friends:
            setInfo(with: modelArray[0])
            statisticView.membersBtn.isEnabled = true
            statisticView.operationsBtn.isEnabled = true
            statisticView.membersBtn.setImage(#imageLiteral(resourceName: "Arrow-1"), for: .normal)
            statisticView.operationsBtn.setImage(#imageLiteral(resourceName: "Arrow-1"), for: .normal)
            statisticView.segmentController.selectedSegmentIndex = 0
            navigationItem.title = "Bonuses from friends"
        case .familiars:
            setInfo(with: modelArray[1])
            statisticView.membersBtn.isEnabled = false
            statisticView.operationsBtn.isEnabled = false
            statisticView.membersBtn.setImage(UIImage(), for: .normal)
            statisticView.operationsBtn.setImage(UIImage(), for: .normal)
            navigationItem.title = "Bonuses from familiars"
            statisticView.segmentController.selectedSegmentIndex = 1
            
        default:
            setInfo(with: modelArray[2])
            statisticView.membersBtn.isEnabled = false
            statisticView.operationsBtn.isEnabled = false
            statisticView.membersBtn.setImage(UIImage(), for: .normal)
            statisticView.operationsBtn.setImage(UIImage(), for: .normal)
            statisticView.segmentController.selectedSegmentIndex = 2
            navigationItem.title = "Bonuses from strangers"
        }
    }
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
    }
    @objc func handlePop(){
        dismiss(animated: true) {
            
        }
        
    }
    private func setInfo(with model: Referals?){
        guard let model = model else { return }
        statisticView.membersBtn.setTitle(String(model.members) + " " + peopleCount, for: .normal)
        statisticView.operationsBtn.setTitle(String(model.orders), for: .normal)
        statisticView.pendingBtn.setTitle(String(model.pending) + " " + currency, for: .normal)
        statisticView.creditedBtn.setTitle(String(model.credited) + " " + currency, for: .normal)
        
    }
    
    @IBAction func showMembersBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "membersVC") as! MembersController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func showOperationsBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OperationsVC") as! OperationsController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func switchSegmentController(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            statisticFor = .friends
        case 1:
            statisticFor = .familiars
        case 2:
            statisticFor = .strangers
        default:
            break
        }
    }
}



