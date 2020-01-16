//
//  UDHelper.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

extension UserDefaultsHelper
{
    static var appSettings: SettingsModel
    {
        get { return UserDefaultsHelper.loadSettings() }
        set { UserDefaultsHelper.saveSettingsDataWithModel(newValue) }
    }
    
    fileprivate static func saveSettingsDataWithModel(_ model: SettingsModel)
    {
        let dict:UserDataType = ["sortedIndex" : model.selectedSegment as AnyObject, "notification" : model.isNotificatiOn as AnyObject]
        
        UserDefaultsHelper.saveUserData(objectToSave: dict, andKey: "Settings")
    }
    
    fileprivate static func loadSettings() -> SettingsModel
    {
        var settingsModel = SettingsModel(isNotificatiOn: true, selectedSegment: 0)
        
        UserDefaultsHelper.loadData(forKey: "Settings")
        {
            guard let sortedIndex = $0?["sortedIndex"] as? Int,
                let notification = $0?["notification"] as? Bool else
            {
                return
            }
            
            settingsModel = SettingsModel(isNotificatiOn: notification, selectedSegment: sortedIndex)
        }
        
        return settingsModel
    }
}
