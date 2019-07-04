//
//  FinishRegView.swift
//  Tips-Mart
//
//  Created by Andrey Petrovskiy on 7/4/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit

class FinishRegView: UIView {
    
    @IBOutlet weak var surnameTf: UITextField!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var birthDateTF: UITextField!
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
        setPlaceholders()
        setBirthDate()
        pickerVIew.setValue(UIColor.white, forKey: "textColor")
        pickerVIew.setValue(false, forKey: "highlightsToday")
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
    private func setBirthDate(){
        birthDateTF.layer.borderWidth = 1
        birthDateTF.layer.borderColor = UIColor.white.cgColor
        birthDateTF.inputView = pickerVIew
    }
    private func setPlaceholders(){
        birthDateTF.attributedPlaceholder = NSAttributedString(string: "  01-09-1939", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
         nameTf.attributedPlaceholder = NSAttributedString(string: "Ведите Ваше имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
         surnameTf.attributedPlaceholder = NSAttributedString(string: "Ведите Вашу Фамилию", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
}


extension FinishRegView: UITextFieldDelegate{
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "  dd-MM-yyyy"
        textField.text = dateFormatter.string(from: pickerVIew.date)
        return true
    }
    
}
