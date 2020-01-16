//
//  EditableCategoryModel.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

/**
 protocol Editable Category : this category can be edited
 - name : category name
 - color : string representation of the UIColor
 */
protocol EditableCategory : TaskCategory
{
    var name:String { get set }
    var color:String { get set }
}

/** struct Editable Category model :  store the date of the category
 - name : category name
 - color : string representation of the UIColor
 */
struct EditableCategoryModel : EditableCategory
{
    var name:String
    var color:String
    
    init(taskModel info: TaskCategory)
    {
        name = info.name
        color = info.color
    }
    
    init(name: String, color: String)
    {
        self.name = name
        self.color = color
    }
}

//Encapsulates all presentable item for Category
typealias CategoryPresentable = ColorPresentable & CategoryLabelPresentable

/** struct Category Creator View Model : helps update the view
 - model : category model
 */
struct CategoryCreatorViewModel : CategoryPresentable
{
    var model: TaskCategory
}

/** extension Category Creator View Model : return the default valuer inside the model
 - category : category name
 - color : category UIColor
 */
extension CategoryCreatorViewModel
{
    var category:String { return model.name }
    var color:UIColor { return UIColor.convertRGBStringToColor(model.color) }
}
