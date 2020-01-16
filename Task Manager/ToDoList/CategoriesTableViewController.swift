//
//  CategoriesTableViewController.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/21/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

// MARK: - Categories Table View Controller

class CategoriesTableViewController: CategoryBaseViewController
{
    // MARK: - view life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //instatiate DataRequester
        dataRequester = DataRequester()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //Request categories
        fetchCategories()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? NewEditCategoryTableViewController
        {
            vc.dataRequester = self.dataRequester
            
            //Verify if is a Cell sends the event. if its true the user is trying to edit the task
            guard let cell = sender as? UITableViewCell,
                let index = tableView.indexPath(for: cell) else { return }
            
            //get the cateogry
            let model = categories![index.row]
            
            //Give the Category from CoreData for editing
            vc.editableManagedObject = model.managedObject
            //Create and Editable Category Model
            vc.editableCategoryModel = EditableCategoryModel(taskModel: model)
        }
    }
}
