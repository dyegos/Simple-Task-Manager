//
//  CategoryModel.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

/**
 protocol Task Category : this category cannot be edited
 - name : category name
 - color : string representation of the UIColor
 */
protocol TaskCategory : CustomStringConvertible
{
    var name:String { get }
    var color:String { get }
}

/** 
 Extends description to show the data inside
 */
extension TaskCategory
{
    var description:String { return "- name: \(name) color: \(color) -" }
}

/** struct Category model
 - managedObject :  when disponable has a ManagedObject from CoreData
 - name : category name
 - color : string representation of the UIColor
 */
struct CategoryModel : TaskCategory
{
    let managedObject:Category?
    
    let name:String
    let color:String
    
    init(name:String, color:String)
    {
        self.managedObject = nil
        self.name = name
        self.color = color
    }
    
    init(managedObject: Category)
    {
        self.managedObject = managedObject
        self.name = managedObject.name
        self.color = managedObject.color
    }
}