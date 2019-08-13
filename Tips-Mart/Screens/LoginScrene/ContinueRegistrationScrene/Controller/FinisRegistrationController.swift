//
//  FinisRegistrationController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/4/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class FinisRegistrationController: UIViewController {
    
    @IBOutlet var finishRegView: FinishRegView!
    //MARK: Properties
    let animation = CustomBlurView()
    
    
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow-2"), with: " Назад", with: .forceLeftToRight)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "Arrow-1"), with: "Пропустить ", with: .forceRightToLeft)
    let keyboardHeight: CGFloat = 200
    var originalPosition: CGRect! //= UIScreen.main.bounds
    //MARK: Life cycle
    var userProfile: UserProfile!
    override func viewDidLoad() {
        super.viewDidLoad()
        originalPosition = self.view.bounds
        addTargets()
        addTap()
        addNotifForKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setClearNavigation(with: .white, with: "")
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        addRightButtonToNavigationBar(with: setItemForNavigationBar(button: rightBarButton))
    }
    
    private func startAnim(){
        animation.frame = self.view.bounds
        self.view.addSubview(animation)
        animation.startAnimation()
    }
    func addNotifForKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(){
        if self.view.bounds == originalPosition{
            self.view.bounds.origin.y = keyboardHeight
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        
    }
    @objc func keyboardWillHide(){
//        self.view.frame = originalPosition
        self.view.bounds.origin.y = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = .purple
    }
    //StatusBar style
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    //MARK: Methods
  
    @objc func handlePop(){
        self.navigationController?.popViewController(animated: true)
        
    }
    //add targets to items
    private func addTargets(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
        rightBarButton.addTarget(self, action: #selector(handlePush), for: .touchUpInside)
    }
    // Gesture for end editing
    func addTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tap)
    }
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    @objc func handlePush(){
        startAnim()
        self.presentMainTabBar()
    }
    
    @IBAction func sendUserSettings(_ sender: UIButton) {
        startAnim()
        let birthDay = finishRegView.birthDateTF.text
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: currentDate)
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from: birthDay ?? dateString)
        let timeInterval = date?.timeIntervalSince1970
        let unixDate = Int(timeInterval!)
        userProfile = UserProfile(name: finishRegView.nameTf.text, surname: finishRegView.surnameTf.text, email: nil, birthday: unixDate, maritalStatus: "single")
        UserSettingsNetwork(model: self.userProfile).sendRequest { (op) in
           
        }
         self.presentMainTabBar()
    }
    
    private func presentMainTabBar(){
        OperationQueue.main.addOperation {
            let tabBarController = UIStoryboard(name: "MainTabBar", bundle: nil).instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBarController
            
            self.present(tabBarController, animated: true) {
                self.animation.stopAnim()
            }
        }
    }
}
