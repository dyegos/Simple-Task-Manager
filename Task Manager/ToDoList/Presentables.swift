//
//  Presentables.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import Foundation
import UIKit

//Enable Category Label
protocol CategoryLabelPresentable
{
    var category:String { get }
}

//Enable Task Label
protocol TaskLabelPresentable
{
    var task:String { get }
}

//Enable Date Label
protocol DateLabelPresentable
{
    var date:String { get }
}

//Enable NSDate
protocol DatePresentable
{
    var date:Date { get }
}

//Enable UIColor
protocol ColorPresentable
{
    var color:UIColor { get }
}

//Enable Checkmark
protocol CheckMarkPresentable
{
    var isChecked:Bool { get }
}

//Enable Simple Label
protocol LabelPrensentable
{
    var text:String { get }
}

//Enable Switch
protocol SwitchPresentable
{
    var isOn:Bool { get }
}

//Enable Notification Switch
protocol NotificationSwitchPresentable
{
    var isNotificationOn:Bool { get }
}

//Enable Notification Switch
protocol DoneSwitchPresentable
{
    var isDone:Bool { get }
}

//Enable SegmentedControl
protocol SegmentedControlPresentable
{
    var selectedSegment:Int { get }
}
