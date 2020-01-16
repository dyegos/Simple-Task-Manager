//
//  TableViewController.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/23/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

/**
 Enable Tap to end editting on view
 */
protocol TapGestureToEndEditing
{
    func addTapGestureToEndEditing()
    func tapGestureReconizer(_ gesture: UITapGestureRecognizer)
}

//Extends and hadles TapGestureToEndEditing
extension UITableViewController : TapGestureToEndEditing
{
    @objc func tapGestureReconizer(_ gesture: UITapGestureRecognizer)
    {
        //End editting
        self.view.endEditing(true)
    }
    
    /**
     Adds the Gesture
     */
    func addTapGestureToEndEditing()
    {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureReconizer(_:)))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
}
