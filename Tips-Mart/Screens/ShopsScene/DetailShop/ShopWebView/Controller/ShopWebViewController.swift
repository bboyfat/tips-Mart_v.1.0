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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url{
            loadUrl(stringUrl: url)
        }
    }
    
    
    
    
    func loadUrl(stringUrl: String){
        guard  let url = URL(string: stringUrl) else {
            return
        }
        let urlReq = URLRequest(url: url)
        webView.load(urlReq)
    }
    
    
    
}
