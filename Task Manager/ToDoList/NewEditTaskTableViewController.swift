//
//  NewItemTableViewController.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/12/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit
import CoreData

// MARK: - New/Edit Item Table View Controller

class NewEditTaskTableViewController: UITableViewController, DataRequesterProtocol, CategorySelectorDataSource
{
    // MARK: - Properties
    
    //Data Requester reference
    var dataRequester: DataRequester?
    //Reference to the NSManageableObject that is being edited
    var editableManagedObject: TaskItem?
    //Object that contains the view information
    var editableTaskObject: EditableTask?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak fileprivate var taskNameLabel: UITextField?
    @IBOutlet weak fileprivate var taskDatePicker: UIDatePicker?
    @IBOutlet weak fileprivate var categoryLabel: UILabel?
    @IBOutlet weak fileprivate var doneSwitch: UISwitch?
    @IBOutlet weak fileprivate var enableNotificationSwitch: UISwitch?
    { didSet { enableNotificationSwitch?.isOn = UserDefaultsHelper.appSettings.isNotificatiOn } }
    
    // MARK: - IBActions
    
    @IBAction fileprivate func saveItem(_ sender: UIBarButtonItem)
    {
        //Force end editing to save the data properly
        taskNameLabel?.endEditing(true)
        
        //Verify the model data if it is legible
        guard let name = editableTaskObject?.name, name != RawData.name,
            let date = editableTaskObject?.date,
            let category = editableTaskObject?.category.name, category != RawData.categoryName,
            let color = editableTaskObject?.category.color,
            let isDone = editableTaskObject?.isDone,
            let isNotificationEnabled = editableTaskObject?.notificationEnabled else
            {
                createAlertWithTitle("Warning", andMessage: "Verify if task name, deadline and category are set")
                return
            }
        
        //Verify if editableManagedObject is valid for an editable item
        if let taskItem = editableManagedObject
        {
            //Updates taskItem
            taskItem.name = name
            taskItem.date = date
            taskItem.category = category
            taskItem.color = color
            taskItem.isDone = isDone
            taskItem.notificationEnabled = isNotificationEnabled
            
            //Saves in CoreData
            self.dataRequester?.coreDataHelper.updateContext()
            //Pop the view
            self.navigationController?.popToRootViewController(animated: true)
            return
        }
        
        //Save a new Task on CoreData
        self.dataRequester?.coreDataHelper.saveNewTask(name, date: date, category: category, color: color, hasPassed: false, isDone: isDone, isNotificationEnabled: isNotificationEnabled)
        {
            if let error = $0
            {
                print("Error: \(error)")
                self.createAlertWithTitle("Warning", andMessage: "Couldn't do your request, try later")
                return
            }
            
            //Pop the view
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Creates target to notify when the DatePicker's values changed
        taskDatePicker?.addTarget(self, action: #selector(datePickerValueChanged(_:)),
                                  for: UIControl.Event.valueChanged)
        
        doneSwitch?.addTarget(self, action: #selector(switchValueChanged(_:)), for: UIControl.Event.valueChanged)
        //Sets the delegate to watch for changes in the -taskNameLabel-
        taskNameLabel?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        //When view appears it tries to update the view
        updateView()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //Verifies if Category Selector VC is not null
        if let categoriesVC = segue.destination as? CategorySelectorTableViewController
        {
            //Gives Data Request reference
            categoriesVC.dataRequester = self.dataRequester
            //Sets Category Selector delegate
            categoriesVC.delegate = self
        }
    }
    
    // MARK: - Category Selector DataSource Delegate
    
    func didSelectCategory(_ model: CategoryModel)
    {
        //Get the category info from the Category Selector VC
        editableTaskObject?.category = model
    }
}

// MARK: - Task Editor protocol

protocol TaskEditor
{
    var editableManagedObject: TaskItem? { get set }
    var editableTaskObject: EditableTask? { get set }
    var isEditMode:Bool { get }
}

extension TaskEditor
{
    var isEditMode:Bool { return editableManagedObject == nil ? true : false }
}

// MARK: - UILabelDelegate extension to get value changes

extension NewEditTaskTableViewController : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        //Initiate gesture to dismiss keyboard
        addTapGestureToEndEditing()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        editableTaskObject?.name = textField.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField.resignFirstResponder()
    }
}

// MARK: - extension to get value DatePicker changes

extension NewEditTaskTableViewController
{
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker)
    {
        //Animates if the date selected is lower than the today date and time
        UIView.animate(withDuration: 0.2, animations: {
            datePicker.superview?.backgroundColor = datePicker.date < Date() ? UIColor.betterRed() : UIColor.white
        })
        
        
        editableTaskObject?.date = datePicker.date.description
    }
}

// MARK: - extension to get UISwitch value changes

extension NewEditTaskTableViewController
{
    @objc func switchValueChanged(_ doneSwitch:UISwitch)
    {
        guard let _ = editableManagedObject else
        {
            doneSwitch.isOn = false
            return
        }
        
        editableTaskObject?.isDone = doneSwitch.isOn
    }
}

// MARK: - Task Editor extension

extension NewEditTaskTableViewController : TaskEditor
{
    //Defines default data for new Tasks
    fileprivate struct RawData
    {
        static let name: String = ""
        static let date: String = ""
        static let categoryName: String = "No Category"
        static let categoryColor: String = ""
        static let hasPassed: Bool = false
        static let notificationEnabled: Bool = UserDefaultsHelper.appSettings.isNotificatiOn
        static let isDone: Bool = false
    }
    
    /****
     * This method keeps the view updated.
     * When it tries to update and -editableTaskObject- is nos valid
     * a new one will be created and the view will be updated.
     * When -editableTaskObject- is valid the method just updates the view.
     ****/
    fileprivate func updateView()
    {
        //check is editableTask is valid. if not, creates a new task. if yes, just update the view
        guard let editableTO = editableTaskObject else
        {
            //Create a new CategoryModel with default RawData values
            let categoryModel = CategoryModel(name: RawData.categoryName, color: RawData.categoryColor)
            //instantiated the object that holds the task data
            editableTaskObject = EditableTaskModel(name: RawData.name, date: RawData.date, hasPassed: RawData.hasPassed, isDone: RawData.isDone,notificationEnabled: RawData.notificationEnabled, category: categoryModel)
            
            //Updates Views
            configure(TaskViewerViewModel(model: editableTaskObject!))
            return
        }
        
        //updates the view with existing data
        configure(TaskViewerViewModel(model: editableTO))
    }
    
    // MARK: - View Configuration
    
    fileprivate func configure(_ viewModel: ViewTaskPresentable)
    {
        taskNameLabel?.text = viewModel.task
        taskDatePicker?.date = viewModel.date as Date
        categoryLabel?.text = viewModel.category
        categoryLabel?.superview?.backgroundColor = viewModel.color
        doneSwitch?.isOn = viewModel.isDone
        enableNotificationSwitch?.isOn = viewModel.isNotificationOn
        
        //Disable switch when creating a new task
        doneSwitch?.isEnabled = !isEditMode
        //Disable switch when editing task
        enableNotificationSwitch?.isEnabled = isEditMode
    }
}
