//
//  EditProfileView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 8/5/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit
import SwiftPhoneNumberFormatter
class EditProfileView: UIView{

@IBOutlet weak var birthDateTF: UITextField!
    
    @IBOutlet weak var phoneNumberTf: PhoneFormattedTextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var nameTf: UITextField!
    
    let pickerVIew: UIDatePicker = {
    let picker = UIDatePicker()
    picker.timeZone = NSTimeZone.local
    picker.backgroundColor = UIColor.purple
    picker.tintColor = UIColor.white
    picker.datePickerMode = .date
    return picker
}()
let rightButton = UINavigationItem.setTheBUtton(with: #imageLiteral(resourceName: "iconfinder_68.calendar_3044694"), with: "", with: .unspecified)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        birthDateTF.delegate = self
        birthDateTF.rightView = setItems(button: rightButton)
        birthDateTF.rightViewMode = .always
        
        setBirthDate()
        pickerVIew.setValue(UIColor.white, forKey: "textColor")
        pickerVIew.setValue(false, forKey: "highlightsToday")
    }
    
    private func setBirthDate(){
        let color: UIColor = #colorLiteral(red: 0.1137254902, green: 0.8, blue: 0.4274509804, alpha: 1)
        birthDateTF.layer.borderWidth = 1
        birthDateTF.layer.borderColor = color.cgColor
        birthDateTF.layer.cornerRadius = 5
        birthDateTF.inputView = pickerVIew
    }
    private func setItems(button: UIButton) -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        view.frame.origin.x = 100
        view.tintColor = .white
        view.addSubview(button)
        button.frame = view.bounds
        
        return view
    }
    
}
extension EditProfileView: UITextFieldDelegate{
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "  dd-MM-yyyy"
        textField.text = dateFormatter.string(from: pickerVIew.date)
        return true
    }
    
}
