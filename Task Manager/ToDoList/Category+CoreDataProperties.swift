//
//  Category+CoreDataProperties.swift
//  TaskManager
//
//  Created by dyego de jesus silva on 12/02/2017.
//  Copyright © 2017 Dyego Silva. All rights reserved.
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category");
    }

    @NSManaged public var color: String
    @NSManaged public var name: String

}
