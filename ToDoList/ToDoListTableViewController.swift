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
   
    public var addEdit = true
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        addEdit = true
        self.performSegue(withIdentifier: "Add", sender: self)
        
    }
    var taskList = [Task] ()

    private var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = taskList[indexPath.row].name
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addEdit = false
        selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "Add", sender: taskList[indexPath.row])
        
    }
    @IBAction func unwindfor(segue: UIStoryboardSegue){
        
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            taskList.remove(at: index)
            tableView.reloadData()
        }
    }
}

