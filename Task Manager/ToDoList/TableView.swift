//
//  TableViewController.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

// MARK: UITableView extension - Reload All Sections

extension UITableView
{
    func reloadAllSectionsWithAnimation()
    {
        let sectionRange = NSRange(location: 0, length: self.numberOfSections)
        self.reloadSections(IndexSet(integersIn: Range(sectionRange) ?? 0..<0), with: UITableView.RowAnimation.none)
    }
}
