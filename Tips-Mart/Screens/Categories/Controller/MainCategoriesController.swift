//
//  MainCategoriesController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/11/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

import UIKit
import NotificationCenter

class MainCategoriesController: UIViewController {
    
    @IBOutlet weak var topTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var serviceTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var productTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var servicesTableView: UITableView!
    
    @IBOutlet weak var showFilteredBtn: UIButton!
    
    let categories = CategoriesForFilter.shared
    
    var categoriesFor: CategoriesFor = .shops
    
    
    var isFullProdHeight = false
    var isFullServHeight = false
    
    var productTableViewDelegate: TableDataSourceDelegate?
    
    var servicesTableViewDelegate: TableDataSourceDelegate?
    
    var onlineTableViewDelegate: TableDataSourceDelegate?
    
    var filter: FilterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchCategoriesFor()
        
        
        getOvserver()
        
        
        
    }
    
    func switchCategoriesFor(){
        switch categoriesFor{
        case .map:
            setProducts()
            setServices()
            topTableViewHeight.constant = 0
        case .shops:
            setServices()
            setProducts()
            setTopTable()
        }
    }
    
    func getOvserver(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(notifUpdate), name: NSNotification.Name(rawValue: "Filtered"), object: categories)
    }
    
    
    
    
    @objc func notifUpdate(_ notification: Notification){
        if let data = notification.object as? CategoriesForFilter{
            self.showFilteredBtn.setTitle("Показать \(data.filteredShopsCount) магазинов", for: .normal)
        }
    }
    @IBAction func showFiltredBtnAction(_ sender: UIButton) {
        dismiss(animated: true) {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(productsTableView.contentSize.height)
        changeHeight()
    }
    private  func setProducts(){
        productTableViewDelegate = TableDataSourceDelegate(categoryType: .products)
        productTableViewDelegate?.tableView = productsTableView
        productsTableView.delegate = productTableViewDelegate
        productsTableView.dataSource = productTableViewDelegate
    }
    private  func setServices(){
        servicesTableViewDelegate = TableDataSourceDelegate(categoryType: .services)
        servicesTableViewDelegate?.tableView = servicesTableView
        servicesTableView.delegate = servicesTableViewDelegate
        servicesTableView.dataSource = servicesTableViewDelegate
    }
    
    private func setTopTable(){
        onlineTableViewDelegate = TableDataSourceDelegate(categoryType: .online)
        onlineTableViewDelegate?.tableView = topTableView
        onlineTableViewDelegate?.isTopTable = true
        topTableView.delegate = onlineTableViewDelegate
        topTableView.dataSource = onlineTableViewDelegate
    }
    
    func changeHeight(){
        productTableViewDelegate!.contentHeight = {[weak self] in
            self?.productTableViewHeight.constant = $0
            UIView.animate(withDuration: 0.4) {
                self?.view.layoutIfNeeded()
            }
        }
        servicesTableViewDelegate!.contentHeight = {[weak self] in
            self?.serviceTableViewHeight.constant = $0
            UIView.animate(withDuration: 0.4) {
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func showProducts(_ sender: Any) {
        isFullProdHeight = !isFullProdHeight
        if let  delegate = productTableViewDelegate{
            if isFullProdHeight{
                productTableViewHeight.constant = (delegate.tableView?.contentSize.height)!
                UIView.animate(withDuration: 0.4) {
                    self.view.layoutIfNeeded()
                }
            } else {
                productTableViewHeight.constant = 220
                UIView.animate(withDuration: 0.7) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        
        
        
    }
    @IBAction func showServices(_ sender: Any) {
        isFullServHeight = !isFullServHeight
        if let  delegate = servicesTableViewDelegate{
            if isFullServHeight{
                serviceTableViewHeight.constant = (delegate.tableView?.contentSize.height)!
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            } else {
                serviceTableViewHeight.constant = 220
                UIView.animate(withDuration: 0.4) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        
        
    }
    @IBAction func filterActionSheetPresent(_ sender: Any) {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let popularity = UIAlertAction(title: "По популярности", style: .default) { (_) in
            
        }
        let cashbackValue = UIAlertAction(title: "По размеру кэшбэка ", style: .default) { (_) in
            
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel) { (_) in
            
        }
        
        ac.addAction(popularity)
        ac.addAction(cashbackValue)
        ac.addAction(cancelAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    @IBAction func closeVcBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
