//
//  CellCategoryModel.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

typealias CategoryCell = CategoryLabelPresentable & ColorPresentable & CheckMarkPresentable

struct CategoryViewModel : CategoryCell
{
    var model:CategoryModel
}

extension CategoryViewModel
{
    var color: UIColor { return UIColor.convertRGBStringToColor(model.color) }
    var category: String { return model.name }
    var isChecked: Bool { return false }
}
