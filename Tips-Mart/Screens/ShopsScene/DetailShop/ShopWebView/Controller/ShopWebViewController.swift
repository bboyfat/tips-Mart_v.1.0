//
//  ShopWebViewController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/31/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import WebKit

class ShopWebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var url: String?
    
    var animation = CustomBlurView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimatio()
        if let url = url{
            loadUrl(stringUrl: url)
        }
    }
    func startAnimatio(){
        animation.frame = self.view.bounds
        self.view.addSubview(animation)
        animation.startAnimation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    
    
    
    func loadUrl(stringUrl: String){
        guard  let url = URL(string: stringUrl) else {
            return
        }
        let urlReq = URLRequest(url: url)
        webView.load(urlReq)
        animation.stopAnim()
    
    }
    
    
    
}
