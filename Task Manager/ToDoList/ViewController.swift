//
//  ViewController.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/22/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

//Extends and creates simple Alert Actions
extension UIViewController
{
    //Creates an simples alert on the screen
    func createAlertWithTitle(_ title: String, andMessage message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
