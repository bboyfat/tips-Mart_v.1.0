//
//  DetailShopController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/12/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class DetailShopController: UIViewController {
    
    //MARK: Properties
    
    var dataSourceDelegate: ReviewDSD!
    var model: Shop!
    var shopData: ShopDataRealm!
    var pathToShop: String = ""
    var htmlParser = HTMLParser()
    var shopNetworkService: ShopNetworkService!
    
    //MARK: Outlets
    @IBOutlet var shopView: DetailShopView!
    @IBOutlet weak var reviewTableView: UITableView!
    //button for navigation bar
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow-2"), with: " Назад", with: .forceLeftToRight)
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getShopData()  //getting network data
        addTarget()  //adding target to nav button
        setDelegates()
        
    }

        
    //MARK: Methods
    private func setItems(button: UIButton) -> UIView{
        let view = UIView()
        view.addSubview(button)
        view.frame = button.bounds
        return view
    }
    private func getShopData(){
        shopNetworkService = ShopNetworkService(pathToshop: pathToShop)
        shopNetworkService.sendRequest { (shop) in
            self.model = shop
            self.setViews()
        }
    }
    private func setDelegates(){
        dataSourceDelegate = ReviewDSD(tableView: reviewTableView)
        reviewTableView.dataSource = dataSourceDelegate
        reviewTableView.delegate = dataSourceDelegate
    }
    func setViews(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: setItems(button: leftBarButton))
        navigationItem.title = pathToShop.uppercased()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1882352941, green: 0.7882352941, blue: 0.4274509804, alpha: 1)
        shopView.cashbackCurrencyLbl.text = shopData.currency
        shopView.cashBackValueLbl.text = String(shopData.value)
        shopView.attentionLbl.text = htmlParser.parseHTML(htmlContent: model.data?.warningInfo ?? "<WARNING INFO>")
        shopView.cashbackTimeLbl.text = model.data?.timeProcessing
        shopView.informationLabel.text = htmlParser.parseHTML(htmlContent: model.data?.description ?? "<HER TAM>")
    }
    
    //add target to items
    private func addTarget(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
    }
    @objc func handlePop(){
       
            self.dismiss(animated: true, completion: nil)

        
    }
    //MARK: IBActions
    
    @IBAction func buyingRules(_ sender: UIButton) {
        let vc = UIStoryboard(name: "OneShop", bundle: nil).instantiateViewController(withIdentifier: "RulesVc") as! BuyingRulesController
        navigationController?.pushViewController(vc, animated: true)
    }
  
    @IBAction func presentReviewScreen(_ sender: UIButton) {
        let vc = UIStoryboard(name: "OneShop", bundle: nil).instantiateViewController(withIdentifier: "ReviewVC") as! ReviewViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
