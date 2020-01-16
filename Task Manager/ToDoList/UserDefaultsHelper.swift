//
//  UserDefaultsHelper.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import Foundation

struct UserDefaultsHelper
{
    typealias UserDataType = [String : AnyObject]
    typealias UserDataCompletion = (UserDataType?) -> Void
    
    static func saveUserData(objectToSave dict: UserDataType, andKey key:String)
    {
        UserDefaults.standard.set(dict, forKey: key)
    }
    
    static func loadData(forKey key:String, completion: UserDataCompletion)
    {
        guard let dict = UserDefaults.standard.object(forKey: key) as? UserDataType else
        {
            completion(nil)
            return
        }
        
        completion(dict)
    }
}
