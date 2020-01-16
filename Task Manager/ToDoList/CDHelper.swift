//
//  CDHelper.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import Foundation
import CoreData

// MARK: - CoreData Helper extension

extension CoreDataHelper
{
    //default dictionary type for action's values
    typealias CoreDataObjects = [String : AnyObject]
    
    //model entities names from CoreData
    fileprivate enum CoreDataEntities : String
    {
        case ToDoItems = "TaskItem"
        case Categories = "Category"
    }
    
    /**
    Fetch all created tasks in CoreData
    - completion : return an array of NSManagedObject, can be nil
     */
    func fetchTaskItems(_ completion: ([TaskItem]?) -> Void)
    {
        //Call completion with fetched data
        completion(self.fetch(request: TaskItem.fetchRequest()))
    }
    
    /**
     Fetch all created categories in CoreData
     - completion : return an array of NSManagedObject, can be nil
     */
    func fetchCategories(_ completion: ([Category]?) -> Void)
    {
        //Call completion with fetched data
        completion(self.fetch(request: Category.fetchRequest()))
    }
    
    /**
     Save a new task in CoreData
     - name : task name
     - date : string representation of the NSDate
     - category : task category
     - color : string representation of the UIColor
     - hasPassed : if the task has past dued or not
     - isDone : if the task is done or not
     - completion : return an error, can be nil
     */
    func saveNewTask(_ name: String, date: String, category: String, color: String, hasPassed: Bool,
                     isDone: Bool, isNotificationEnabled:Bool, completion: @escaping (String?) -> Void)
    {
        //Create a dictionary with all task values
        let values:CoreDataObjects = ["name" : name as AnyObject, "date" : date as AnyObject, "category" : category as AnyObject, "color" : color as AnyObject, "hasPassed" : hasPassed as AnyObject, "isDone" : isDone as AnyObject, "notificationEnabled" : isNotificationEnabled as AnyObject]
        
        //start to save a task in CoreData
        self.saveNewObject(CoreDataEntities.ToDoItems.rawValue, objectValues: values) { completion($0) }
    }
    
    /**
     Save a new category in CoreData
     - name : category name
     - color : string representation of the UIColor
     - completion : return an error, can be nil
     */
    func saveNewCategory(_ name: String, color: String, completion: @escaping (String?) -> Void)
    {
        //Create a dictionary with all categories's values
        let values:CoreDataObjects = ["name" : name as AnyObject, "color" : color as AnyObject]
        
        //start to save the category in CoreData
        self.saveNewObject(CoreDataEntities.Categories.rawValue, objectValues: values) { completion($0) }
    }
    
    /**
     Save an array of categories in CoreData
     - categories : array of categories
     - completion : return an error, can be nil
     */
    func saveCategoriesWithArray(_ categories: [CategoryModel], completion: @escaping (String?) -> Void)
    {
        //Create an array of dictionary with all categories values formated
        let objectsValues = categories.map { ["name" : $0.name as AnyObject, "color" : $0.color as AnyObject] as CoreDataObjects }
        
        //Start to save all categories in CoreData
        saveNewObjects(CoreDataEntities.Categories.rawValue, objectsValues: objectsValues) { completion($0) }
    }
    
    /**
     Store in CoreData if an task is done or not
     - task : CoreData TaskItem
     - isDone : default value is true
     */
    func markTaskAsDone(_ task: TaskItem, isDone: Bool = true)
    {
        //edit task
        task.isDone = isDone
        
        //updates context
        updateContext()
    }
}

// MARK: - Cretes dummy tasks

extension CoreDataHelper
{
    func createDummyDueEntity()
    {
        let dateString2 = "2016-06-20 10:10:10 +0000"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
        dateFormatter.locale = Locale.current
        let dateFromString = dateFormatter.date(from: dateString2)
        
        self.saveNewTask("Dummy", date: dateFromString!.description, category: "No Category", color: "0.0 1.0 0.0", hasPassed: false, isDone: true, isNotificationEnabled: true)
        { print("\(String(describing: $0))") }
    }
    
    func createDummyDoneEntity()
    {
        let dateString2 = "2016-04-20 10:10:10 +0000"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
        dateFormatter.locale = Locale.current
        let dateFromString = dateFormatter.date(from: dateString2)
        
        self.saveNewTask("Dummy Past", date: dateFromString!.description, category: "No Category", color: "1.0 0.0 0.0", hasPassed: true, isDone: false, isNotificationEnabled: false)
        { print("\(String(describing: $0))") }
    }
}
