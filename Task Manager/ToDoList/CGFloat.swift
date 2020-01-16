//
//  CGFloat.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

extension CGFloat
{
    init?(_ value:String)
    {
        guard let iValue = Double(value) else { return nil }
        
        self = CGFloat(iValue)
    }
}