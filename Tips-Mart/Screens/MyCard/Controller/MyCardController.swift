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
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "creditCardWhite"), with: "", with: .unspecified)
    var generator = BarCodeGenerator()
    var model: RealmUserData!
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
        myCardView.idLbl.text = model.id.separate(every: 2, with: " ")
        myCardView.barCodeImage.image = generator.generateBrCode(from: model.id)
        myCardView.nickNameLbl.text = model.nickname
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
    }
    
    
    @objc func handlePop(){
        self.dismiss(animated: true, completion: nil)
        
    }
}
