//
//  Array.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import Foundation

extension Array where Element : Task
{
    func sortByDate() -> [Element] { return self.sorted(by: compareAscendingDate) }
    func sortAlphabetically() -> [Element] { return self.sorted(by: compareAscendingName) }
}
