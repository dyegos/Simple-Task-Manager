//
//  NewCategoryTableViewController.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/21/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

// MARK: - New Category Table View Controller

class NewEditCategoryTableViewController: UITableViewController, DataRequesterProtocol
{
    // MARK: - @IBOutlet
    
    @IBOutlet weak internal var categoryNameLabel: UITextField? { didSet { categoryNameLabel?.delegate = self } }
    @IBOutlet weak internal var colorLabel: UILabel?
    
    // MARK: - Properties
    
    var dataRequester: DataRequester? // Data Requester reference
    var editableCategoryModel: EditableCategory? // Category model
    //Reference to the NSManagebleObject thas is being edited
    var editableManagedObject: Category?
    
    // MARK: - @IBAction methods
    
    @IBAction func saveCategory(_ sender: UIBarButtonItem)
    {
        //Force end editing to save the data properly
        categoryNameLabel?.endEditing(true)
        
        //Verity if the data is legible to save in CoreData
        guard let name = editableCategoryModel?.name, name != "",
            let color = editableCategoryModel?.color, color != "" else
        {
            createAlertWithTitle("Warning", andMessage: "All fields are required")
            return
        }
        
        //Verify if editableManagedObject is valid for an editable item
        if let taskItem = editableManagedObject
        {
            //Updates taskItem
            taskItem.name = name
            taskItem.color = color
            
            //Saves in CoreData
            self.dataRequester?.coreDataHelper.updateContext()
            //Pop the view
            _ = self.navigationController?.popViewController(animated: true)
            return
        }
        
        //Start the request to save a new category
        dataRequester?.coreDataHelper.saveNewCategory(name, color: color)
        { [unowned self] in
            
            if let error = $0
            {
                print("Error: \(error)")
                self.createAlertWithTitle("Warning", andMessage: "Couldn't do your request, try later")
            }
            
            //Go back to previous View Controller
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - View life cycle
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let selector = segue.destination as? ColorSelectorTableViewController
        {
            selector.delegate = self
        }
    }
}

// MARK: - Extends and hendle UITextFieldDelegate

extension NewEditCategoryTableViewController : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        //Add a Tap Gesture to hide the keyboard
        addTapGestureToEndEditing()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        editableCategoryModel?.name = textField.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField.resignFirstResponder()
    }
}

// MARK: - Extends and hendle ColorSelectorProtocol

extension NewEditCategoryTableViewController : ColorSelectorProtocol
{
    func didSelectColor(_ stringRepresentation: String)
    {
        colorLabel?.text = ""
        editableCategoryModel?.color = stringRepresentation
    }
    
    fileprivate func updateUI()
    {
        //Verify if the model is valid
        guard let editableCategory = editableCategoryModel else
        {
            editableCategoryModel = EditableCategoryModel(name: "", color: "")
            configure(CategoryCreatorViewModel(model: editableCategoryModel!))
            return
        }
        
        //updated the view
        configure(CategoryCreatorViewModel(model: editableCategory))
    }
    
    //configures the view with the presenter
    fileprivate func configure(_ presenter: CategoryPresentable)
    {
        categoryNameLabel?.text = presenter.category
        colorLabel?.superview?.backgroundColor = presenter.color
    }
}
