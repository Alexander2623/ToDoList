//
//  TodoListDataDisplayManager.swift
//  ToDoList
//
//  Created by Александр on 14.07.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

protocol TodoListDataDisplayManagerDelegate: class {
    func didSelectTask(addEdit:Bool, indexPath: IndexPath)

}

class ToDoListDataDisplayManager: NSObject {
    weak var delegate: TodoListDataDisplayManagerDelegate?
    var tasks: [Task] = []
    
    func setupWithTasks(_ tasks: [Task]) {
        self.tasks = tasks
    }
}

// MARK: UITableViewDataSourse

extension ToDoListDataDisplayManager: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].name
        
        return cell
    }
}

// MARK: UITableViewDelegate

extension ToDoListDataDisplayManager: UITableViewDelegate{
    
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        if (editingStyle == .delete) {
            tasks.remove(at: index)
            tableView.reloadData()
        }
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       delegate?.didSelectTask(addEdit: false, indexPath: indexPath)
    }
}
