//
//  TaskItem+CoreDataProperties.swift
//  TaskManager
//
//  Created by dyego de jesus silva on 12/02/2017.
//  Copyright © 2017 Dyego Silva. All rights reserved.
//

import Foundation
import CoreData


extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem");
    }

    @NSManaged public var category: String
    @NSManaged public var color: String
    @NSManaged public var date: String
    @NSManaged public var hasPassed: Bool
    @NSManaged public var isDone: Bool
    @NSManaged public var name: String
    @NSManaged public var notificationEnabled: Bool

}
