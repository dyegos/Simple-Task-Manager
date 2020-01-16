//
//  CoreDataHelper.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/11/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import CoreData
import UIKit

// MARK: - CoreData Helper Protocol

protocol CoreDataHelperProtocol
{
    var coreDataHelper: CoreDataHelper { get }
}

// MARK: - CoreData Context Protocol

protocol CoreDataContextProtocol
{
    var context:AppDelegate { get }
}

// MARK: - CoreData Helper

struct CoreDataHelper : CoreDataContextProtocol
{
    //Stores AppDelegate delegate reference
    var context: AppDelegate = { return UIApplication.shared.delegate as! AppDelegate }()
    
    /**
     Saves a new Object in CoreData
     - entity :  entity's name
     - objectValues : values to be saved : a dictionary
     - completion :  return an error. can be nil
     */
    func saveNewObject(_ entity: String, objectValues: CoreDataObjects, completion: (String?) -> Void)
    {
        //create a NSManagedObject
        let object = NSEntityDescription.insertNewObject(forEntityName: entity, into: self.context.managedObjectContext)
        
        //Put all values inside the object
        objectValues.forEach { object.setValue($1, forKey: $0) }
        
        // Tries to save the object in CoreData
        do
        {
            try context.managedObjectContext.save()
            
            completion(nil) // no error here
        }
        //call completion with error
        catch { completion("fails to save object") }
    }
    
    /**
     Saves Objects in CoreData
     - entity :  entity's name
     - objectsValues : values to be saved. An array of dictionaries
     - completion :  return an error. can be nil
     */
    func saveNewObjects(_ entity: String, objectsValues: [CoreDataObjects], completion: (String?) -> Void)
    {
        //creates an array of object with their values
        objectsValues.forEach
        {
            let object = NSEntityDescription.insertNewObject(forEntityName: entity, into: self.context.managedObjectContext)
            $0.forEach { object.setValue($1, forKey: $0) }
        }
        
        // Tries to save the objects in CoreData
        do
        {
            try context.managedObjectContext.save()
            
            completion(nil)
        }
        //call completion with error
        catch { completion("Got some Error") }
    }
    
    /**
     Fetch data from CoreData
     - entityName :  entity to be fetched
     - return an array of AnyObject. can be nil
     */
    func fetch<T>(request: NSFetchRequest<T> ) -> [T]? {
        return try? context.managedObjectContext.fetch(request)
    }
    
    /**
     Update CoreData context
     */
    func updateContext()
    {
        context.saveContext()
    }
    
    /**
     Delete an object from CoreData
     - object :  object to be deleted
     - completion :  return an error. can be nil
     */
    func deleteObject(_ object: NSManagedObject, completion: (String?) -> Void)
    {
        //Get the context and tries to delete
        context.managedObjectContext.delete(object)
        
        //tries to save
        do
        {
            try context.managedObjectContext.save()
            
            completion(nil)
        }
        catch { completion("Counldn't delete the object") }
    }
}
