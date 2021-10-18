//
//  ViewController.swift
//  UserDefaultsExample2
//
//  Created by ruslan on 16.10.2021.
//

import UIKit

enum SexType: String {
    case male
    case female
}

class UserModel: NSObject, NSCoding {
    
    let name: String
    let surname: String
    let city: String
    let sex: SexType
    
    init(name: String, surname: String, city: String, sex: SexType) {
        self.name = name
        self.surname = surname
        self.city = city
        self.sex = sex
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(surname, forKey: "surname")
        coder.encode(city, forKey: "city")
        coder.encode(sex.rawValue, forKey: "sex")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        surname = coder.decodeObject(forKey: "surname") as? String ?? ""
        city = coder.decodeObject(forKey: "city") as? String ?? ""
        let rawValue = coder.decodeObject(forKey: "sex") as? String ?? ""
        sex = SexType(rawValue: rawValue) ?? SexType.male
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var cityPickerView: UIPickerView!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    
    let cities = ["Moscow", "Prague", "Tokyo", "Los Angeles", "Toronto", "Berlin"]
    var pickedCity: String?
    var pickedSex: SexType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UserDefaults.standard.removeObject(forKey: "userModel")
//        UserDefaults.standard.synchronize()
        
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        
        if let model = UserSettings.userModel {
            nameTextField.text = model.name
            surnameTextField.text = model.surname
            if let row = cities.firstIndex(of: model.city) {
                cityPickerView.selectRow(row, inComponent: 0, animated: true)
            } else {
                cityPickerView.selectRow((cities.count / 2) - 1, inComponent: 0, animated: true)
            }
            if model.sex.rawValue == "male" {
                sexSegmentedControl.selectedSegmentIndex = 0
            } else {
                sexSegmentedControl.selectedSegmentIndex = 1
            }
        }
    }

    @IBAction func saveButton(_ sender: Any) {
        
        switch sexSegmentedControl.selectedSegmentIndex {
        case 0:
            pickedSex = .male
        case 1:
            pickedSex = .female
        default:
            break
        }
        
        guard let nameText = nameTextField.text, let surnameText = surnameTextField.text else { return }
        let nameTrimmingText = nameText.trimmingCharacters(in: .whitespaces)
        let surnameTrimmingText = surnameText.trimmingCharacters(in: .whitespaces)
        
        guard let pickedCity = pickedCity, let pickedSex = pickedSex else { return }
        let userObject = UserModel(name: nameTrimmingText,
                                   surname: surnameTrimmingText,
                                   city: pickedCity,
                                   sex: pickedSex)
        UserSettings.userModel = userObject
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedCity = cities[row]
    }
}
