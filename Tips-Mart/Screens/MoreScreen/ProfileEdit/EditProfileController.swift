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
                self.editView.birthDateTF.text = self.stringToDateToString(date: data.birthday)
                self.customAnimation.stopAnim()
            } else {
                self.customAnimation.stopAnim()
            }
        }
    }
    private func stringToDateToString(date string: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzzZ"
        let date = dateFormatter.date(from: string)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: date!)
        return stringDate
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
        setClearNavigation(with: #colorLiteral(red: 0.1137254902, green: 0.8, blue: 0.4274509804, alpha: 1), with: NSLocalizedString("editProfile", comment: ""))
        setTitleColor(with: #colorLiteral(red: 0.3254901961, green: 0.003921568627, blue: 0.737254902, alpha: 1))
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
                    self.addAllert()
                }
            }
        } else {
            self.customAnimation.stopAnim()
            self.addAllert()
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
    func addAllert(){
        let ac = UIAlertController(title: "Ooops", message: "Something went wrong, try later", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        ac.addAction(action)
        self.present(ac, animated: true, completion: nil)
    }
    
}
