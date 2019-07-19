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
}

class StatisticController: UIViewController, StatisticControllerProtocol {
    
    //MARK: Properties
    
    @IBOutlet var statisticView: StatisticView!

    var statisticFor: StatisticFor = .friends{
        didSet{
            statisticForChenged()
        }
    }
    
    
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: " Назад", with: .forceLeftToRight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        addTargets()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1894809902, green: 0.7875444889, blue: 0.4261831641, alpha: 1)
    }
    
    private func setNavigation(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: setItems(button: leftBarButton))
        navigationController?.navigationBar.isTranslucent = true
        
    }
    private func setItems(button: UIButton) -> UIView{
        let view = UIView()
        view.addSubview(button)
        view.frame = button.bounds
        return view
    }
    private func statisticForChenged(){
        switch statisticFor {
        case .friends:
            statisticView.membersBtn.isEnabled = true
            statisticView.operationsBtn.isEnabled = true
            statisticView.membersBtn.setImage(#imageLiteral(resourceName: "Arrow-1"), for: .normal)
            statisticView.operationsBtn.setImage(#imageLiteral(resourceName: "Arrow-1"), for: .normal)
            statisticView.segmentController.selectedSegmentIndex = 0
            navigationItem.title = "Bonuses from friends"
        case .familiars:
            statisticView.membersBtn.isEnabled = false
            statisticView.operationsBtn.isEnabled = false
            statisticView.membersBtn.setImage(UIImage(), for: .normal)
            statisticView.operationsBtn.setImage(UIImage(), for: .normal)
            navigationItem.title = "Bonuses from familiars"
            statisticView.segmentController.selectedSegmentIndex = 1
           
        default:
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



extension UIViewController{
    #warning("Don't forget to made this part to clean alo of space")
    
    //    private func setNavigation(tintColor: UIColor, button: UIButton){
    //        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    //        navigationController?.navigationBar.shadowImage = UIImage()
    //        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1894809902, green: 0.7875444889, blue: 0.4261831641, alpha: 1)
    //        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
    //        navigationController?.navigationBar.titleTextAttributes = attributes
    //        navigationItem.title = NSLocalizedString("More Details", comment: "")
    //        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: setItems(button: leftBarButton))
    //        navigationController?.navigationBar.isTranslucent = true
    //
    //    }
    //    private func setItems(button: UIButton) -> UIView{
    //        let view = UIView()
    //        view.addSubview(button)
    //        view.frame = button.bounds
    //        return view
    //    }
    //
}
