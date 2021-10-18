//
//  UserSettings.swift
//  UserDefaultsExample2
//
//  Created by ruslan on 18.10.2021.
//

import Foundation

final class UserSettings {
    
    private enum SettingsKeys: String {
//        case userName
        case userModel
    }
    
//    static var userName: String! {
//
//        get {
//            return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
//        }
//
//        set {
//            let defaults = UserDefaults.standard
//            let key = SettingsKeys.userName.rawValue
//            if let name = newValue {
//                defaults.set(name, forKey: key)
//                print("\(name) was added")
//            } else {
//                defaults.removeObject(forKey: key)
//                print("name wasn't added")
//            }
//        }
//    }
    
    static var userModel: UserModel! {
        
        get {
            guard let data = UserDefaults.standard.data(forKey: SettingsKeys.userModel.rawValue), let model = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserModel else { return nil }
            return model
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userModel.rawValue
            if let model = newValue {
                if let data = try? NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false) {
                    defaults.set(data, forKey: key)
                }
            }
        }
    }
}
