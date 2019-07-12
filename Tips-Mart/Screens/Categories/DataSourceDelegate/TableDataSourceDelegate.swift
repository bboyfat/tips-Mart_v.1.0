//
//  TableDataSourceDelegate.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/11/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import Foundation

import UIKit
import RealmSwift

enum SwithcForTable{
    case opened
    case closed
}
enum Online: String{
    case online = "online"
    case offline = "offline"
}

class TableDataSourceDelegate: NSObject, UITableViewDataSource {
    
    var isTopTable = false
    var isOpened = false
    var tableView: UITableView?
    
    var categoriesForFilter = CategoriesForFilter.shared
    var filter: FilterProtocol!
    
    var viewModel: CategoryViewModelDelegate!
    
    var contentHeight: (CGFloat) -> () = { _ in}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let nib = UINib.init(nibName: "RowsCatCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "rowsCatCell")
        return viewModel.sectionsCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.getCategory(with: section).switchTable{
        case .opened: return viewModel.rowsCount(in: section)
        case .closed: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowsCatCell", for: indexPath) as! RowsCatCell
        let model = viewModel.getCategory(with: indexPath.section)
        cell.categoriesLabel?.text = model.subCategories[indexPath.row].name
        
        let cellSelectedModel = SelectedModel.shared
        cellSelectedModel.selectedRowAt.forEach { (index) in
            if indexPath == index{
                tableView.selectRow(at: index, animated: true, scrollPosition: .none)
            }
        }
        // here i'm getting count of shops by category
        cell.shopsCountlbl.text = "\(filter.getShopsByCatCount(model.subCategories[indexPath.row].categoryID))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewForHeade = HeaderView()
        viewForHeade.tag = section
        viewForHeade.categoriLabel.text = viewModel.getCategory(with: section).name
        viewForHeade.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpen)))
        if isTopTable{
            if viewForHeade.categoriLabel.text == "Онлайн"{
                viewForHeade.shopsCount.text = "\(filter.getOnlineCount())"
            } else {
                viewForHeade.shopsCount.text = "\(filter.getOfflineCount())"
            }
        }
        return viewForHeade
    }
    
    //MARK: show hiden cells
    @objc func handleOpen(_ sender: UITapGestureRecognizer){
        isOpened = !isOpened
        if let view = sender.view as? HeaderView{
            if isOpened{
                viewModel.openClose(in: view.tag, opened: .opened)
                self.tableView?.reloadSections(IndexSet(integer: view.tag), with: .none)
            } else {
                viewModel.openClose(in: view.tag, opened: .closed)
                self.tableView?.reloadSections(IndexSet(integer: view.tag), with: .none)
            }
            // closure to change tableView height
            contentHeight((tableView?.contentSize.height)!)
        }
    }
    override init() {
        super.init()
        
    }
    
    private func fetchShops(){
        do{
            let realm = try Realm()
            let array = Array(realm.objects(ShopDataRealm.self))
            self.filter = Filter(model: array)
        } catch {
            print("Can't FETCH!!")
        }
        
    }
    
    init(categoryType: CategorieType) {
        viewModel = CategoryViewModel(categoryType: categoryType)
        super.init()
        self.fetchShops()
    }
    
}

extension TableDataSourceDelegate: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryID =  viewModel.getCategory(with: indexPath.section).subCategories[indexPath.row].categoryID
        if !categoriesForFilter.categories.contains(categoryID){
            categoriesForFilter.categories.append(categoryID)
        }
        let cellSelectedModel = SelectedModel.shared
        cellSelectedModel.indexPath = indexPath
        let array = filter.filter(categories: categoriesForFilter.categories, online: nil)
        categoriesForFilter.filteredShopsCount = array.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let categoryID =  viewModel.getCategory(with: indexPath.section).subCategories[indexPath.row].categoryID
        if categoriesForFilter.categories.contains(categoryID){
            categoriesForFilter.categories.remove(categoryID)
        }
        let cellSelectedModel = SelectedModel.shared
        cellSelectedModel.indexPath = indexPath
        print(indexPath)
        let array = filter.filter(categories: categoriesForFilter.categories, online: nil)
        categoriesForFilter.filteredShopsCount = array.count
        
    }
    
}
