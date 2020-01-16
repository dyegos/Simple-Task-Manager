//
//  EditableTaskModel.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import Foundation

/**
 protocol Editable Task : this task can be edited
 - name : category name
 - date : string representation of NSDate
 - hasPassed : store when the task past dued
 - isDone : store when the task is done or not
 - category : task category model
 */
protocol EditableTask : Task
{
    var name:String { get set }
    var date:String { get set }
    var hasPassed:Bool { get set }
    var isDone:Bool { get set }
    var notificationEnabled:Bool { get set }
    var category:TaskCategory { get set}
}

/**
 struct Editable Task : this task can be edited
 - name : category name
 - date : string representation of NSDate
 - hasPassed : store when the task past dued
 - isDone : store when the task is done or not
 - category : task category model
 -
 - init with model init(taskModel info: Task)
 - init with default parameters init(name: String, date: String, hasPassed: Bool, isDone:Bool, category: TaskCategory)
 */
struct EditableTaskModel : EditableTask
{
    var name:String
    var date:String
    var hasPassed:Bool
    var isDone:Bool
    var notificationEnabled:Bool
    var category:TaskCategory
    
    init(taskModel info: Task)
    {
        name = info.name
        date = info.date
        hasPassed = info.hasPassed
        notificationEnabled = info.notificationEnabled
        isDone = info.isDone
        category = info.category
    }
    
    init(name: String, date: String, hasPassed: Bool, isDone:Bool, notificationEnabled:Bool, category: TaskCategory)
    {
        self.name = name
        self.date = date
        self.hasPassed = hasPassed
        self.isDone = isDone
        self.notificationEnabled = notificationEnabled
        self.category = category
    }
}