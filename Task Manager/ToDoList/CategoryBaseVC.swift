//
//  CategoryBaseVC.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/21/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

/**
 Delegate patter do get data if any category is selected
 */
protocol CategorySelectorDataSource : class
{
    func didSelectCategory(_ model:CategoryModel) -> Void
}

/**
 Enables categories models
 */
protocol CategoryViewer
{
    var categories:[CategoryModel]? { get }
}

// MARK: - Category Base View Controller

class CategoryBaseViewController: UITableViewController
{
    var dataRequester: DataRequester?
    internal var categories:[CategoryModel]?
    
    // MARK: - View lifeCycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Get categories
        fetchCategories()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return categories?.count ?? 0
    }
    
    // MARK: - Cell creation
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.CategoryCell, for: indexPath) as! CategoryTableViewCell
        
        //Configure the cell
        let model = self.categories![indexPath.row]
        cell.configure(CategoryViewModel(model: model))
        
        return cell
   }
}

// MARK: - UILabelDelegate extension to get value changes

extension CategoryBaseViewController : DataRequesterProtocol, CategoryViewer
{
    /**
     Creates default values for categoris if there's none
     */
    func createDefaultCategories()
    {
        //instatiage array
        categories = []
        
        //Apped Defaul values
        categories?.append(CategoryModel(name: "Trip", color: UIColor.betterYellow().toString()))
        categories?.append(CategoryModel(name: "Work", color: UIColor.betterOrange().toString()))
        categories?.append(CategoryModel(name: "Food", color: UIColor.gray.toString()))
        categories?.append(CategoryModel(name: "Drink", color: UIColor.betterBrown().toString()))
        
        //Save the categoires
        dataRequester?.coreDataHelper.saveCategoriesWithArray(categories!)
        { [unowned self] in
            
            if let error = $0
            {
                print("Error saving categories: \(error)")
            }
            
            //Reload Table
            self.tableView.reloadData()
        }
    }
    
    func fetchCategories()
    {
        //Fectch all categories
        dataRequester?.requestCategories
        { [unowned self] in
            
            guard let objects = $1, objects.count > 0 else
            {
                print("No cateogies or erro saving one: \(String(describing: $0))")
                
                self.createDefaultCategories()
                return
            }
            
            self.categories = objects
            self.tableView.reloadData()
        }
    }
}
