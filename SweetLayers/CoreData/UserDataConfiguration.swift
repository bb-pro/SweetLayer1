//
//  UserDataConfiguration.swift
//  SweetLayers
//
//  Created by 1 on 17/01/25.
//

import Foundation

class UserDataConfiguration {
    static let shared = UserDataConfiguration()
    let coins = "coins"
    let levels = "levels"
    let blower = "blower"
    let timer = "timer"
    let bonusDate = "bonusDate"
    let bonusIndex = "index"
    let backgroundIndex = "backgroundIndex"
    let availableBackgrounds = "availableBackgrounds"
    let defaults = UserDefaults.standard

    func setInitialValues() {
        if defaults.value(forKey: coins) == nil {
            defaults.setValue(60, forKey: coins)
        }
        if defaults.value(forKey: levels) == nil {
            defaults.setValue([0], forKey: levels)
        }
        if defaults.value(forKey: blower) == nil {
            defaults.setValue(0, forKey: blower)
        }
        if defaults.value(forKey: timer) == nil {
            defaults.setValue(0, forKey: timer)
        }
        if defaults.value(forKey: bonusDate) == nil {
            let oneDayAgo = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            defaults.setValue(oneDayAgo, forKey: bonusDate)
        }
        if defaults.value(forKey: bonusIndex) == nil {
            defaults.setValue(-1, forKey: bonusIndex)
        }
        if defaults.value(forKey: backgroundIndex) == nil {
            defaults.setValue(0, forKey: backgroundIndex)
        }
        
        if defaults.value(forKey: availableBackgrounds) == nil {
            defaults.setValue([0], forKey: availableBackgrounds)
        }
    }
    
    func updateValues(key: String, value: Any) {
        defaults.setValue(value, forKey: key)
    }
    
    func getValueOfKey(key: String) -> Any {
        return defaults.value(forKey: key) as Any
    }
    
    func getCoins() -> Int {
        return defaults.value(forKey: coins) as! Int
    }
    func fetchLastDateOfBonus() -> Date {
        return defaults.value(forKey: bonusDate) as! Date
    }
}
