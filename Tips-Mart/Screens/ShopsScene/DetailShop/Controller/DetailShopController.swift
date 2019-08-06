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
    var customBlurAnimtion = CustomBlurView()
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
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        getShopData()  //getting network data
        addTarget()  //adding target to nav button
        setDelegates()
        LogoNetworkService().getImages(with: shopData.pathImage) { (image) in
            OperationQueue.main.addOperation {
                self.shopView.logoImageVIew.image = image
            }
            
        }
        
    }
        
    //MARK: Methods
    private func setupAnimation(){
        customBlurAnimtion.frame = self.view.bounds
        self.view.addSubview(customBlurAnimtion)
        customBlurAnimtion.startAnimation()
    }
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
//        navigationItem.title = .uppercased()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1882352941, green: 0.7882352941, blue: 0.4274509804, alpha: 1)
        shopView.cashbackCurrencyLbl.text = shopData.currency
        var string: String = ""
        model.data?.listCashbacks?.forEach({ (cash) in
            string += "\n" + String(cash.value) + cash.typeCurrency + " " + cash.name.ru
           
           
        })
        shopView.cashBackValueLbl.text = String(shopData.value)
         shopView.lisCashbackLbl.text = string
        
        shopView.attentionLbl.text = htmlParser.parseHTML(htmlContent: model.data?.warningInfo ?? "<WARNING INFO>")
        shopView.cashbackTimeLbl.text = model.data?.timeProcessing
        shopView.informationLabel.text = htmlParser.parseHTML(htmlContent: model.data?.description ?? "<HER TAM>")
         customBlurAnimtion.stopAnim()
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
  
    @IBAction func goToShop(_ sender: UIButton) {
        BuyingNetworkService(path: pathToShop).sendRequest { (finish) in
            if finish{
                let vc = UIStoryboard(name: "ShopWebView", bundle: nil).instantiateViewController(withIdentifier: "ShopWebViewVC") as! ShopWebViewController
                vc.url = self.model.data?.refLink
                OperationQueue.main.addOperation {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            } else {
                
            }
        }
        
    }
    @IBAction func presentReviewScreen(_ sender: UIButton) {
        let vc = UIStoryboard(name: "OneShop", bundle: nil).instantiateViewController(withIdentifier: "ReviewVC") as! ReviewViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
