//
//  BuyingRulesController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/16/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import WebKit
class BuyingRulesController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    let urlString  = "https://tips-mart.com/shopping-rules"
    //button for navigation bar
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow-2"), with: " Назад", with: .forceLeftToRight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl(stringUrl: urlString)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: setItems(button: leftBarButton))
        navigationItem.title = "Правила покупок"
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1882352941, green: 0.7882352941, blue: 0.4274509804, alpha: 1)
        addTarget()
        // Do any additional setup after loading the view.
    }
    //MARK: Methods
    
    func loadUrl(stringUrl: String){
        guard  let url = URL(string: stringUrl) else {
            return
        }
        let urlReq = URLRequest(url: url)
        webView.load(urlReq)
    }
    private func setItems(button: UIButton) -> UIView{
        let view = UIView()
        view.addSubview(button)
        view.frame = button.bounds
        return view
    }
    // add target to items
    private func addTarget(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
    }
    @objc func handlePop(){
        if navigationController != nil{
            navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
