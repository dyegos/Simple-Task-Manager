//
//  TaskModel.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

/**
 protocol Task : base for all Task models
 - name : category name
 - date : string representation of NSDate
 - hasPassed : store when the task past dued
 - isDone : store when the task is done or not
 - category : task category model
 - notificationEnabled : knows when a task has a notification scheduled
 */
protocol Task : CustomStringConvertible
{
    var name:String { get }
    var date:String { get }
    var hasPassed:Bool { get }
    var isDone:Bool { get }
    var notificationEnabled:Bool { get }
    var category:TaskCategory { get }
}

//Extends description to show the data inside
extension Task
{
    var description:String { return "name: \(name) date: \(date) has Passed:\(hasPassed) categoty: \(category)" }
}