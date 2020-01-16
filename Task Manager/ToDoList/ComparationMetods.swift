//
//  Global.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import Foundation

func compareAscendingDate(_ value1: Task, value2:Task) -> Bool
{
    return DateFormatter().formatDate(fromString: value1.date) < DateFormatter().formatDate(fromString: value2.date)
}

func compareDescendingDate(_ value1: Task, value2:Task) -> Bool
{
    return DateFormatter().formatDate(fromString: value1.date) > DateFormatter().formatDate(fromString: value2.date)
}

func compareAscendingName(_ value1: Task, value2:Task) -> Bool
{
    return value1.name < value2.name
}

func compareDescendingName(_ value1: Task, value2:Task) -> Bool
{
    return value1.name > value2.name
}
