//
//  SettingsModel.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import Foundation

//Encapsulates all presentables for Settings
typealias SettingsPresenter = LabelPrensentable & SwitchPresentable & SegmentedControlPresentable

/**
 struct Settings Model
 - isNotificatiOn : store if the notifications is on or not
 - selectedSegment : selected sort order
 */
struct SettingsModel
{
    var isNotificatiOn:Bool
    var selectedSegment:Int
}

/** struct Settings View Model : helps update the view
 - model : settings' model
 */
struct SettingsViewModel : SettingsPresenter
{
    var model:SettingsModel
}

/** extension Settings View Model : return the default valuer inside the model
 - task : notification Enabled name based on isOn value
 - isOn : if the notification is on or not
 - selectedSegment : selected sort order
 */
extension SettingsViewModel
{
    var text: String { return model.isNotificatiOn ? "Enabled" : "Disable" }
    var isOn: Bool { return model.isNotificatiOn }
    var selectedSegment: Int { return model.selectedSegment }
}
