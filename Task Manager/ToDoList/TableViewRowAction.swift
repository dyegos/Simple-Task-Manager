//
//  TableViewAction.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

// MARK: - Extension to that creates row action

extension UITableViewRowAction
{
    typealias actionHandler = (UITableViewRowAction, IndexPath) -> Void
    
    static func createRowActionWithTitle(_ title:String, andColor color: UIColor, style: UITableViewRowAction.Style, handler: @escaping actionHandler) -> UITableViewRowAction
    {
        let action = UITableViewRowAction(style: style, title: title, handler: handler)
        action.backgroundColor = color
        
        return action
    }
}
