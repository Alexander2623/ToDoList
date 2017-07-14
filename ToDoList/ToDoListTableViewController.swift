//
//  ViewController.swift
//  ToDoList
//
//  Created by Александр on 11.07.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    @IBOutlet var mainTableView: UITableView!
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        addEdit = true
        self.performSegue(withIdentifier: "Add", sender: self)
        
    }
    private let displayManager = ToDoListDataDisplayManager()
    public var addEdit = true
    
    var taskList = [Task] () {
        didSet {
            displayManager.setupWithTasks(taskList)
            mainTableView.reloadData()
        }
    }
    
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = displayManager
        tableView.delegate = displayManager
        displayManager.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add"{
            let chooseButton = segue.destination as! AddEditViewController
            chooseButton.createButtonTableView(value: addEdit)
            
            if let task = sender as? Task {
                chooseButton.configureWithTask(task)
            }
        }
    }
    
    func didEditTask(_ task: Task) {
        guard let indexPath = selectedIndexPath else {
            return
        }
        
        taskList[indexPath.row] = task
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        addEdit = false
//        selectedIndexPath = indexPath
//        self.performSegue(withIdentifier: "Add", sender: taskList[indexPath.row])
//        
//    }
    @IBAction func unwindfor(segue: UIStoryboardSegue){
        
    }
    
}

extension ToDoListTableViewController: TodoListDataDisplayManagerDelegate {
    
    func didSelectTask(addEdit: Bool, indexPath: IndexPath) {
        self.addEdit = addEdit
        self.selectedIndexPath = indexPath
        
        self.performSegue(withIdentifier: "Add", sender: taskList[indexPath.row])
        

    }
    func addTask(task: Task){
        
    }
    
}
