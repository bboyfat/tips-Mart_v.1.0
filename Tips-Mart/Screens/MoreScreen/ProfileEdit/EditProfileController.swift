//
//  EditProfileController.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class EditProfileController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet var editView: EditProfileView!
    var userProfile: UserProfile?
    var customAnimation = CustomBlurView()
    let leftBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "greenArrow"), with: "      ", with: .forceLeftToRight)
    let rightBarButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "done"), with: "      ", with: .forceRightToLeft)
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnim()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        setNavigation()
        addTarget()
        addTap()
        
    }
    
    
    //MARK: Methods
    //Start animation after sendeng request
    func getData(){
        ProfielEditNetService().sendRequest { (data) in
            if let data = data{
                self.editView.nameTf.text = data.name
                self.editView.surnameTF.text = data.surname
                self.editView.birthDateTF.text = data.birthday
                self.customAnimation.stopAnim()
            } else {
                self.customAnimation.stopAnim()
            }
        }
    }
    
    func startAnim(){
        customAnimation.frame = self.view.bounds
        self.view.addSubview(customAnimation)
        customAnimation.startAnimation()
    }
    
    func addTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tap)
    }
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    //Set clear navigation
    private func setNavigation(){
        setClearNavigation(with: .green, with: "Prifile Editing")
        setTitleColor(with: .purple)
        addLeftButtonToNavigationBar(with: setItemForNavigationBar(button: leftBarButton))
        addRightButtonToNavigationBar(with: setItemForNavigationBar(button: rightBarButton))
    }
    //adding targets to buttons
    private func addTarget(){
        leftBarButton.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
        rightBarButton.addTarget(self, action: #selector(handleChangeInfo), for: .touchUpInside)
    }
    @objc func handleChangeInfo(){
        startAnim()
        prepareDataToChange()
        sendRequest()
    }
    @objc func handlePop(){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func changeInfoAction(_ sender: UIButton) {
         startAnim()
        prepareDataToChange()
        sendRequest()
    }
    private func sendRequest(){
       
        if let userPrifile = userProfile{
            UserSettingsNetwork(model: userPrifile).sendRequest { (op) in
                if op{
                    self.customAnimation.stopAnim()
                    self.handlePop()
                    let appDelegate = AppDelegate()
                    appDelegate.resetApp()
                } else {
                    self.customAnimation.stopAnim()
                    BalanceAlerts(controller: self).presentInfo("WARNING", BalanceAlertMessage.greenMessage.rawValue)
                }
            }
        } else {
            self.customAnimation.stopAnim()
            BalanceAlerts(controller: self).presentInfo("WARNING", BalanceAlertMessage.greenMessage.rawValue)
        }
    }
    private func prepareDataToChange(){
        let birthday = editView.birthDateTF.text
        self.userProfile = UserProfile(name: editView.nameTf.text, surname: editView.surnameTF.text, email: editView.emailTf.text, birthday: prepareUNIX(from: birthday), maritalStatus: "single")
        
    }
    private func prepareUNIX(from birthDate: String?) -> Int?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let currentDate = Date()
        let stringDate = dateFormatter.string(from: currentDate)
        let date = dateFormatter.date(from: birthDate ?? stringDate)
        let timeInterval = date?.timeIntervalSince1970
        let unixDate = Int(timeInterval ?? TimeInterval())
        return unixDate
    }
    
    
}
