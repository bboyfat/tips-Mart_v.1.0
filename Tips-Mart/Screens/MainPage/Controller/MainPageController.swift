//
//  MainPageControllerViewController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/8/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class MainPageController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var mainView: MainPageView!
    @IBOutlet weak var collectionBanerView: UICollectionView!
    var viewModel = MainPageViewModel()
    var model: RealmUserData!
    let networkService = InitUserService()
    var balancaAlert: BalanceAlerts!
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionBanerView.delegate = self
        collectionBanerView.dataSource = self
        addGesturetoStack()
        balancaAlert = BalanceAlerts(controller: self)
        networkService.sendRequest { (_) in
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setViews()
    }
    @IBAction func myCardBtnAction(_ sender: Any) {
        let vc = UIStoryboard(name: "MyCard", bundle: nil).instantiateViewController(withIdentifier: "MyCardVC") as! MyCardController
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
        
    }
    @IBAction func searchBtn(_ sender: Any) {
        
        if let shops = self.tabBarController?.viewControllers?[1] as? ShopsController{
            shops.senderIs = .search
        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers?[1]
        }
    }
    
    //MARK: Methods
    func addGesturetoStack(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePresent))
        mainView.profileStackView.addGestureRecognizer(tap)
    }
    // presenting of profile screen
    @objc func handlePresent(){
    
        let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileController
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
        
        
    }
    func setViews(){
        viewModel.infoUpdated = {[weak self] in
            guard let model = self?.viewModel.getModel() else {return}
            self?.model = model
            self?.mainView.idLabel.text = model.id.separate(every: 2, with: " ")
            self?.mainView.nicknameLabel.text = model.nickname
        }
        guard let greenBalance = greenBalance() else {return}
        guard let grayBalance = grayBalance() else {return}
        self.mainView.greenBalance.text = String(greenBalance) + " " + NSLocalizedString("uah", comment: "")
        self.mainView.grayBalance.text = String(grayBalance) + " " + NSLocalizedString("uah", comment: "")
       
    }
    @IBAction func grayBalanceInfo(_ sender: UIButton) {
        balancaAlert.presentInfo(NSLocalizedString("grayWallet", comment: ""), BalanceAlertMessage.grayMessage.rawValue)
    }
    @IBAction func greenBalanceInfo(_ sender: UIButton) {
         balancaAlert.presentInfo(NSLocalizedString("greenWallet", comment: ""), BalanceAlertMessage.greenMessage.rawValue)
    }
    @IBAction func otherCardsAction(_ sender: Any) {
        balancaAlert.presentUpdateAlert()
    }
}
extension MainPageController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) 
        
        return cell
    }
    
    
}

extension MainPageController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionBanerView.frame.width, height: self.collectionBanerView.frame.height)
    }
}
