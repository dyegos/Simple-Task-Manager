//
//  CategoriesSelectorTableViewController.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/15/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

class CategorySelectorTableViewController: CategoryBaseViewController
{
    //Crates a delegate to pass category data
    weak var delegate: CategorySelectorDataSource?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //sends data through delegate
        self.delegate?.didSelectCategory(self.categories![indexPath.row])
        //Hides modally
        self.dismiss(animated: true, completion: nil)
    }
}
