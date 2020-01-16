//
//  ToDoTableViewController.swift
//  TaskManager
//
//  Created by iPicnic Digital on 5/11/16.
//  Copyright © 2016 Dyego Silva. All rights reserved.
//

import UIKit
import CoreData

enum TaskSection : Int
{
    case toDo = 0, done
}

// MARK: - To Do Table View Controller

class TasksTableViewController: UITableViewController, DataRequesterProtocol
{
    // MARK: - Properties
    
    lazy var dataRequester: DataRequester? = DataRequester()
    fileprivate var taskItems:[[CellTaskModel]]?
    
    // MARK: - view lifeCycle
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        updateTasks()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return taskItems?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.taskItems?[section].count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ToDoTask, for: indexPath) as! ItemTableViewCell
        
        //Configure the cell
        let viewModel = CellTaskViewModel(model: self.taskItems![indexPath.section][indexPath.row])
        cell.configure(viewModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return section == TaskSection.done.rawValue ? "Done" : "To Do's"
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? NewEditTaskTableViewController
        {
            //Give the data request reference
            vc.dataRequester = self.dataRequester
            
            //Verify if is a Cell sends the event. if its true the user is trying to edit the task
            guard let cell = sender as? UITableViewCell,
                let index = tableView.indexPath(for: cell) else { return }
            
            //get the task
            let model = taskItems![index.section][index.row]
            
            //Give the TaskItem from CoreData for editing
            vc.editableManagedObject = model.managedObject
            //Create and Editing Task Model
            vc.editableTaskObject = EditableTaskModel(taskModel: model)
        }
    }
}

// MARK: - Extension handles the update of the tasks and sorting them

extension TasksTableViewController
{
    fileprivate func updateTasks()
    {
        //Add a sad label
        tableView.addSadLabel()
        //Start requesting all tasks
        dataRequester?.requestToDoItems
        { [unowned self] in
            
            //Verify if there are items inside the array of tasks
            guard let items = $1, items.count > 0 else
            {
                print("Error: \(String(describing: $0))")
                return
            }
            
            //there's no more reason to be sad
            self.tableView.removeSadLabel()
            //Sort and store all tasks
            self.taskItems = self.sortTasks(items)
            self.tableView.reloadData()
        }
    }
    
    fileprivate func sortTasks(_ tasks: [CellTaskModel]) -> [[CellTaskModel]]
    {
        //Verify witch way to sort the list of tasks
        let sortedTasks = UserDefaultsHelper.appSettings.selectedSegment == 0 ? tasks.sortByDate() : tasks.sortAlphabetically()
        
        //Return the [[CellTaskModel]] filtered
        return [sortedTasks.filter { !$0.isDone }, sortedTasks.filter { $0.isDone }]
    }
}

// MARK: - Extension handles the actions on the cell

extension TasksTableViewController
{

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //Nothing to do here
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        //Crete and Array o actions
        var actions:[UITableViewRowAction] = []

        //Add a default Delete Action
        actions.append(UITableViewRowAction.createRowActionWithTitle("Delete", andColor: UIColor.red, style: .destructive, handler: handleRowAction))

        //if the task is not a DoneTask add Done Action
        if (indexPath.section != TaskSection.done.rawValue)
        {
            actions.append(UITableViewRowAction.createRowActionWithTitle("Done", andColor: UIColor.green, style: .default, handler: handleRowAction))
        }

        return actions
    }

    /**
     Handles the row action
     */
    fileprivate func handleRowAction(_ action: UITableViewRowAction, indexPath: IndexPath)
    {
        //verify the Action style and title
        switch (action.style, action.title!)
        {
        case (.default, "Delete"):
            //Remove the cell from the section
            removeCellAtIndexPath(indexPath)
        case (.default, "Done"):
            //Make a task done
            markTaskDoneAtIndexPath(indexPath)
        default: break
        }

        tableView.reloadAllSectionsWithAnimation()
    }

    /**
     Removes a cell from the table
     - indexPath : index path from the cell
     */
    fileprivate func removeCellAtIndexPath(_ indexPath: IndexPath)
    {
        //verify if the managed object inside the model is valid
        guard let objToRemove = taskItems?[indexPath.section][indexPath.row].managedObject else
        {
            print("For some reason the object inside this section is null")
            createAlertWithTitle("warning", andMessage: "Couldn't do this now, try later")
            return
        }

        //Start the request to delete a Task
        dataRequester?.coreDataHelper.deleteObject(objToRemove)
        { [unowned self] in

            if let error = $0
            {
                self.createAlertWithTitle("warning", andMessage: "Couldn't do this now, try later")
                print("Error: \(error)")
                return
            }

            //remove the task from the table
            self.removeCellFromTableWithIndex(indexPath)
        }
    }

    /**
     Mark a task as done
     - indexPath : indexPath from the cell
     */
    fileprivate func markTaskDoneAtIndexPath(_ indexPath: IndexPath)
    {
        //verify if the managed object inside the model is valid
        guard let doneObject = taskItems?[indexPath.section][indexPath.row],
            let managedObject = doneObject.managedObject else
        {
            print("For some reason the object inside this section is null")
            createAlertWithTitle("warning", andMessage: "Couldn't do this now, try later")
            return
        }

        //Make the task done
        dataRequester?.coreDataHelper.markTaskAsDone(managedObject)
        //remove the task from the table
        removeCellFromTableWithIndex(indexPath)
        //insert task in Done Section
        insertCellInSection(TaskSection.done.rawValue, andTask: doneObject)
    }

    /**
     Remove cell from the table
     - indexPath : indexPath from the cell
     */
    fileprivate func removeCellFromTableWithIndex(_ indexPath:IndexPath)
    {
        //remove from array
        taskItems![indexPath.section].remove(at: indexPath.row)
    }

    /**
     Insert a cell in the table
     - section : section number
     - task : TaskModel
     */
    fileprivate func insertCellInSection(_ section:Int, andTask task: CellTaskModel)
    {
        taskItems![section].append(task)
    }
}

