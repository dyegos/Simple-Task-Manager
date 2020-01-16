//
//  UIColor.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

extension UIColor
{
    /**
     Converts RGB string patter "1.0 1.0 1.0 1.0" to a UIColor
    */
    public class func convertRGBStringToColor(_ colorString:String) -> UIColor
    {
        let colorRGB = colorString.components(separatedBy: " ").compactMap { CGFloat($0) }
        
        return colorRGB.count == 0 ? UIColor.white : UIColor(red: colorRGB[0], green: colorRGB[1], blue: colorRGB[2], alpha: 1.0)
    }
    /**
     Transfor any UIColor to a representable String "1.0 1.0 1.0 1.0"
    */
    func toString() -> String
    {
        guard let components = self.cgColor.components else {
            return "1.0 1.0 1.0 1.0"
        }
        
        if components.count > 2 {
            return "\(components[0]) \(components[1]) \(components[2]) \(1.0)"
        }
        
        return "\(components[0]) \(components[0]) \(components[0]) \(1.0)"
    }
    
    //MARK: - Better Default Color for UIColor System
    
    public class func betterBlue() -> UIColor
    {
        return UIColor(red:0.00, green:0.75, blue:1.00, alpha:1.0)
    }
    
    public class func betterYellow() -> UIColor
    {
        return UIColor(red:1.00, green:0.84, blue:0.00, alpha:1.0)
    }
    
    public class func betterRed() -> UIColor
    {
        return UIColor(red:0.86, green:0.08, blue:0.24, alpha:1.0)
    }
    
    public class func betterOrange() -> UIColor
    {
        return UIColor(red:1.00, green:0.65, blue:0.00, alpha:1.0)
    }
    
    public class func betterGreen() -> UIColor
    {
        return UIColor(red:0.60, green:0.80, blue:0.20, alpha:1.0)
    }
    
    public class func betterPink() -> UIColor
    {
        return UIColor(red:1.00, green:0.41, blue:0.71, alpha:1.0)
    }
    
    public class func betterBrown() -> UIColor
    {
        return UIColor(red:0.63, green:0.32, blue:0.18, alpha:1.0)
    }
}
