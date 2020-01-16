//
//  SadLabel.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/21/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

protocol SadLabelPresenter
{
    func addSadLabel()
    func removeSadLabel()
}

extension UITableView : SadLabelPresenter
{
    func addSadLabel()
    {
        //Verify if the label already existis in the view, if true just return
        //to avoid create more than one
        if let _ = self.viewWithTag(-1) { return }
        
        //Create new lable
        let sadLabel = UILabel(frame: CGRect(x: 0, y: self.bounds.midY * 0.5, width: self.bounds.width, height: 20))
        sadLabel.text = "it feels empty here :("
        sadLabel.textAlignment = .center
        sadLabel.tag = -1
        self.addSubview(sadLabel)
    }
    
    func removeSadLabel()
    {
        //remove sad label from the view
        self.viewWithTag(-1)?.removeFromSuperview()
    }
}
