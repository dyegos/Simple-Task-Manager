//
//  ColorSelectorTableViewController.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/21/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

/**
 Delegate patter do get data if any color is selected
 */
protocol ColorSelectorProtocol : class
{
    func didSelectColor(_ stringRepresentation: String) -> Void
}

// MARK: - Color Selector Table View Controller

class ColorSelectorTableViewController: UITableViewController {

    // MARK: - Properties
    
    fileprivate var colors:[ColorModel] = []
    weak var delegate:ColorSelectorProtocol?
    
    // MARK: - View lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDefaultColors()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ColorCell, for: indexPath)

        cell.backgroundColor = colors[indexPath.row].color

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.delegate?.didSelectColor(colors[indexPath.row].color.toString())
        self.dismiss(animated: true, completion: nil)
    }
}

/**
    Holds defaul defaults colors creator
 */
extension ColorSelectorTableViewController
{
    func setUpDefaultColors()
    {
        colors.append(ColorModel(color: UIColor.betterYellow()))
        colors.append(ColorModel(color: UIColor.betterOrange()))
        colors.append(ColorModel(color: UIColor.betterRed()))
        colors.append(ColorModel(color: UIColor.betterPink()))
        colors.append(ColorModel(color: UIColor.betterBlue()))
        colors.append(ColorModel(color: UIColor.betterGreen()))
        colors.append(ColorModel(color: UIColor.betterBrown()))
        colors.append(ColorModel(color: UIColor.gray))
        colors.append(ColorModel(color: UIColor.black))
    }
}
