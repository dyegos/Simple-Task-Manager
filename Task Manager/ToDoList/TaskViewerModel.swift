//
//  TaskManagerModel.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/11/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

//Encapsulates all Presentables for this model
typealias ViewTaskPresentable = CategoryPresentable & TaskLabelPresentable & DatePresentable & NotificationSwitchPresentable & DoneSwitchPresentable

//Create the View Model
struct TaskViewerViewModel : ViewTaskPresentable
{
    let model:Task
}

//Set up default values
extension TaskViewerViewModel
{
    var task:String { return model.name }
    var date:Date { return DateFormatter().formatDate(fromString: model.date) }
    var category:String { return model.category.name }
    var color:UIColor { return UIColor.convertRGBStringToColor(model.category.color) }
    var isDone:Bool { return model.isDone }
    var isNotificationOn:Bool { return model.notificationEnabled }
}
