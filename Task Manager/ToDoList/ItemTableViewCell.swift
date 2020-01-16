//
//  ItemTableViewCell.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/11/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

// MARK: - Item Table View Cell

class ItemTableViewCell: UITableViewCell
{
    // MARK: - @IBOutlet
    
    @IBOutlet fileprivate weak var taskName: UILabel?
    @IBOutlet fileprivate weak var taskDate: UILabel?
    @IBOutlet fileprivate weak var taskCategory: UILabel?
    
    // MARK: - Presenter configuration
    
    func configure(_ presenter: CellTaskViewModel)
    {
        taskName?.text = presenter.task
        taskDate?.text = presenter.date
        taskCategory?.text = presenter.category
        taskCategory?.backgroundColor = presenter.color
        
        //Check if the castegoty past dued and tint properly
        taskDate?.backgroundColor = presenter.hasPassedColor
    }
}
