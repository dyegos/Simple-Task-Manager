//
//  DataRequester.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/12/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import Foundation
import CoreData

/**
    Enables Data Request
 */
protocol DataRequesterProtocol
{
    var dataRequester: DataRequester? { get set }
}

/**
    Makes request from CoreData
 */
class DataRequester : CoreDataHelperProtocol
{
    //Store a reference from CoreDataHelper
    var coreDataHelper = CoreDataHelper()
    
    /**
    Request Task Items
    - completion :  return an error and the tasks requested. both values can be nil
    */
    func requestToDoItems(_ completion:(_ error: String?, _ items: [CellTaskModel]?) -> Void)
    {
        //Start to fetch
        self.coreDataHelper.fetchTaskItems
        {
            //Verify if the object is not null and if the count is above zero
            guard let objects = $0, objects.count > 0 else
            {
                //Call the completion with error
                completion("Error trying to fetch task items or there's no tasks in CoreData", nil)
                return
            }
            
            //Crete an array with valid items
            let taskItems:[CellTaskModel] = objects.compactMap
            {
                //Verify if the task has past due
                let hasPassed = DateFormatter().currentDateIsLowerThan(taskDateString: $0.date)
                //Create the model
                let categoryModel = CategoryModel(name: $0.category, color: $0.color)
                //Return a cell model
                return CellTaskModel(managedObject: $0, name: $0.name, date: $0.date, hasPassed: hasPassed, isDone: $0.isDone, notificationEnabled: $0.notificationEnabled, category: categoryModel)
            }
            
            //call the completion with the items
            completion(nil, taskItems)
        }
    }
    
    /**
     Request Categories
     - completion :  return an error and the categories requested. both values can be nil
     */
    func requestCategories(_ completion:(_ error: String?, _ items: [CategoryModel]?) -> Void)
    {
        //Start to fetch
        self.coreDataHelper.fetchCategories
        {
            //Verify if the object is not null and if the count is above zero
            guard let objects = $0, objects.count > 0 else
            {
                //Call the completion with error
                completion("Fail to fetch categories or there's no categories on CoreData", nil)
                return
            }
            
            //Create an array with all requested categories
            let categoryItems:[CategoryModel] = objects.compactMap { CategoryModel(managedObject: $0) }
            
            //call the completion with the items
            completion(nil, categoryItems)
        }
    }
}
