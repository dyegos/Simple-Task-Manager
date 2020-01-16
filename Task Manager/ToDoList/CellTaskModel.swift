//
//  CellTaskModel.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

/**
 struct Cell Task Model
 - managedObject : store the CoreData model for the Task
 - name : category name
 - date : string representation of NSDate
 - hasPassed : store when the task past dued
 - isDone : store when the task is done or not
 - category : task category model
 */
struct CellTaskModel : Task
{
    let managedObject:TaskItem?
    
    let name:String
    let date:String
    let hasPassed:Bool
    let isDone:Bool
    let notificationEnabled:Bool
    let category:TaskCategory
}

//Encapsulates all presentables of the Cell Task
typealias CellTaskPresentable = CategoryPresentable & TaskLabelPresentable & DateLabelPresentable

/** struct Cell Task View Model : helps update the view
 - model : task model
 */
struct CellTaskViewModel : CellTaskPresentable
{
    let model:Task
}

/** extension Category Creator View Model : return the default valuer inside the model
 - task : task name
 - date : task NSDate formated
 - category : categiry's name
 - color : category UIColor
 */
extension CellTaskViewModel
{
    var task:String { return model.name }
    var date:String { return DateFormatter().formatMediumDateWith(model.date) }
    var category:String { return model.category.name }
    var color:UIColor { return UIColor.convertRGBStringToColor(model.category.color) }
    var hasPassedColor:UIColor { return DateFormatter().formatDate(fromString: model.date) < Date() ? UIColor.betterRed() : UIColor.white }
}
