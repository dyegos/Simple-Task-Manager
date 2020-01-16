//
//  SettingsTableViewController.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/21/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit

// MARK: - Settings Table View Controller

class SettingsTableViewController: UITableViewController
{
    // MARK: - @IBOutlet
    
    @IBOutlet weak fileprivate var sortSelectorControl: UISegmentedControl?
    @IBOutlet weak fileprivate var notificationSwitch: UISwitch?
    @IBOutlet weak fileprivate var notificationStatusLabel: UILabel?
    
    // MARK: - Properties
    
    fileprivate var settingsModel:SettingsModel? { didSet { updateUI() } }
    
    // MARK: - view lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        settingsModel = UserDefaultsHelper.appSettings
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        UserDefaultsHelper.appSettings = settingsModel!
    }
    
    // MARK: - Methods
    
    //Updates the UI
    fileprivate func updateUI()
    {
        //Configure the cells
        let presenter = SettingsViewModel(model: settingsModel!)
        configure(presenter)
    }
    
    //Set all view values into place
    fileprivate func configure(_ presenter: SettingsPresenter)
    {
        sortSelectorControl?.selectedSegmentIndex = presenter.selectedSegment
        notificationSwitch?.isOn = presenter.isOn
        notificationStatusLabel?.text = presenter.text
    }
}

// MARK: - Extends and handles UISwitch changes

extension SettingsTableViewController
{
    @IBAction func switchNotifications(_ sender: UISwitch)
    {
        settingsModel?.isNotificatiOn = sender.isOn
    }
}

// MARK: - Extends and handles UISegmentedControl changes

extension SettingsTableViewController
{
    @IBAction func sortOrderSelector(_ sender: UISegmentedControl)
    {
        settingsModel?.selectedSegment = sender.selectedSegmentIndex
    }
}
