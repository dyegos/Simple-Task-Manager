//
//  DataFormater.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import Foundation

//Handles and Formats NSDate to String replesentation or String replesentation NSDate
extension DateFormatter
{
    //Holds default date format
    fileprivate var taskDateFormat: String { return "yyyy-MM-dd HH:mm:ss ZZZZ" }
    
    /**
    Encapsulates formating NSDate
     - dateString : String repesentation od the NSDate following the format yyyy-MM-dd HH:mm:ss ZZZZ
    */
    fileprivate func setUpDate(_ dateString: String) -> Date
    {
        self.dateFormat = taskDateFormat
        self.locale = Locale.current
        
        return self.date(from: dateString) ?? Date()
    }
    
    /** 
    Return a String representation of the NSDate with MediumStyle
    - dateString : String repesentation od the NSDate following the format yyyy-MM-dd HH:mm:ss ZZZZ
     */
    func formatMediumDateWith(_ dateString: String) -> String
    {
        let date = setUpDate(dateString)
        self.dateStyle = DateFormatter.Style.medium
        
        return self.string(from: date)
    }
    
    /**
    Return NSDate formated from a String without NSDateFormatterStyle
    - dateString : String repesentation od the NSDate following the format yyyy-MM-dd HH:mm:ss ZZZZ
     */
    func formatDate(fromString dateString: String) -> Date
    {
        return setUpDate(dateString)
    }
    
    /**
     Check if a String representation of a NSDate is lower than the current NSDate
     - taskDateString : String repesentation od the NSDate following the format yyyy-MM-dd HH:mm:ss ZZZZ
     */
    func currentDateIsLowerThan(taskDateString dateString: String) -> Bool
    {
        //Creates a NSDate
        let date = setUpDate(dateString)
        
        return date < Date() //Check Dates
    }
}
