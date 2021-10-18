//
//  UserSettings.swift
//  UserDefaultsExample2
//
//  Created by ruslan on 18.10.2021.
//

import Foundation

final class UserSettings {
    
    enum SettingsKeys: String {
        case userName
    }
    
    static var userName: String! {
        
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userName.rawValue
            if let name = newValue {
                defaults.set(name, forKey: key)
                print("\(name) was added")
            } else {
                defaults.removeObject(forKey: key)
                print("name wasn't added")
            }
        }
    }
}
