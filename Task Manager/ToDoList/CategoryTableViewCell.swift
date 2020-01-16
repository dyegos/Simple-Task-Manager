//
//  CategoryTableViewCell.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/15/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell
{
    //Configures the cell
    func configure(_ presenter: CategoryViewModel)
    {
        self.textLabel?.text = presenter.category
        self.backgroundColor = presenter.color
        self.accessoryType = presenter.isChecked ? .checkmark : .none
    }
}
