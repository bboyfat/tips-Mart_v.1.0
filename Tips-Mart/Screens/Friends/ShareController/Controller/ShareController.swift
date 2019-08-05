//
//  ShareController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/18/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ShareController: UIViewController {
    
    @IBOutlet var shareView: ShareVIew!
    
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "       ", with: .forceLeftToRight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: .white, with: NSLocalizedString("More Details", comment: ""))
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        setTitleColor(with: .white)
        
    }
    @IBAction func copyBtn(_ sender: Any) {
        copyToClipBoard(textToCopy: shareView.linkTf.text!)
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
        presentActivityControler(text: [shareView.linkTf.text!])
    }
    func presentActivityControler(text: [Any]){
        let textToShare = text
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToTwitter, UIActivity.ActivityType.copyToPasteboard ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
    }
    @objc func handlePop(){
        navigationController?.popViewController(animated: true)
    }
    
}
