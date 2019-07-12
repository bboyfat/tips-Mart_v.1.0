//
//  ProfileController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/9/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    //MARK: Properties
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow"), with: "", with: .forceLeftToRight)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Icon"), with: "", with: .forceRightToLeft)
    //StatusBar style
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets() // add targets fot items
        setNavigation() // setup navigation bar
    }
    
    
    //MARK: Methods
    private func setNavigation(){
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
       
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: setItems(button: rightBarButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: setItems(button: leftBarButton))
        navigationController?.navigationBar.isTranslucent = true
        
    }
    private func setItems(button: UIButton) -> UIView{
        let view = UIView()
        view.addSubview(button)
        view.frame = button.bounds
        return view
    }
    
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
        rightBarButton.addTarget(self, action: #selector(handlePush), for: .touchUpInside)
    }
    @objc func handlePop(){
         self.dismiss(animated: true, completion: nil)
      
        
    }
    @objc func handlePush(){
      
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
