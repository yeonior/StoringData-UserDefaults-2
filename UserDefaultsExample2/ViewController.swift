//
//  ViewController.swift
//  UserDefaultsExample2
//
//  Created by ruslan on 16.10.2021.
//

import UIKit

enum SexType {
    case male
    case female
}

class UserModel {
    
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
}

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var cityPickerView: UIPickerView!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    
    let cities = ["Moscow", "Prague", "Tokyo", "Los Angeles", "Toronto"]
    var pickedCity: String?
    var pickedSex: SexType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        cityPickerView.selectRow(2, inComponent: 0, animated: true)
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
        print(userObject)
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
