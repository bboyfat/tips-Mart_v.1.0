//
//  MyCardController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/31/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class MyCardController: UIViewController {
    
    @IBOutlet var myCardView: MyCardView!
    
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "    ", with: .forceRightToLeft)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "creditCardWhite"), with: "      ", with: .forceRightToLeft)
    var generator = BarCodeGenerator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        setClearNavigation(with: .white, with: "Моя карта")
        setTitleColor(with: .white)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        addRightButtonToNavigationBar(with: setItemForNavigationBar(button: rightBarButton))
        setClearNavigation(with: .white, with: "Моя карта")
        setTitleColor(with: .white)
        addTargets()
        setViews()
    }
    private func setViews(){
        guard let nick = nickname() else { return}
        guard let id = userId() else {return}
        guard let greenBalance = greenBalance() else {return}
        guard let grayBalance = grayBalance() else {return}
        self.myCardView.nickNameLbl.text = nick
        self.myCardView.greenBalance.text = String(greenBalance) + " " + NSLocalizedString("uah", comment: "")
        self.myCardView.grayBalance.text = String(grayBalance) + " " + NSLocalizedString("uah", comment: "")
        self.myCardView.idLbl.text = String(id).separate(every: 2, with: " ")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        OrientationManager.landscapeSupported = true
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        OrientationManager.landscapeSupported = false
        //The code below will automatically rotate your device's orientation when you exit this ViewController
        let orientationValue = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(orientationValue, forKey: "orientation")
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        switch UIDevice.current.orientation{
        case .portrait:
            myCardView.infoViewHeight.constant = 110.5
        case .portraitUpsideDown:
            myCardView.infoViewHeight.constant = 0
        case .landscapeLeft:
            myCardView.infoViewHeight.constant = 0
        case .landscapeRight:
            myCardView.infoViewHeight.constant = 0
        default:
            myCardView.infoViewHeight.constant = 110.5
        }
    }
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
        rightBarButton.addTarget(self, action: #selector(handleAlert), for: .touchDragInside)
    }
    
    @objc func handleAlert(){
        let balanceAlerts = BalanceAlerts(controller: self)
        balanceAlerts.presentUpdateAlert()
    }
    @objc func handlePop(){
        self.dismiss(animated: true, completion: nil)
        
    }
}
