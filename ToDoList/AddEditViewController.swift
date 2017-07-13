//
//  AddEditViewController.swift
//  ToDoList
//
//  Created by Александр on 11.07.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import Foundation
import UIKit

class AddEditViewController: UIViewController {
    
    @IBOutlet weak var addEditTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "NameTableViewCell", bundle: Bundle.main)
            addEditTableView.register(nib, forCellReuseIdentifier: "NameTableViewCell")
            let nib1 = UINib(nibName: "DescriptionTableViewCell", bundle: Bundle.main)
            addEditTableView.register(nib1, forCellReuseIdentifier: "DescriptionTableViewCell")
        }
    }
    
    var task: Task = Task(name: "", description: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addEditTableView.dataSource = self
        addEditTableView.delegate = self
        
        // TODO:
        // 1. Оповещать об изменениях в полях VC
        // 2. Сохранять значения в модель / поля
        // 3. При нажатии на кнопку Save/Edit передовать модель на экран Todo List
    }
    
    
    
    func createButtonTableView (value: Bool){
        if value{
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector (goBack))
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector (cancelButton))
            
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(goBack))
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector (cancelButton))
        }
        
    }
    
    func configureWithTask(_ task: Task) {
        self.task = task
    }
    
    func cancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goBack(sender: Any){
        performSegue(withIdentifier: "backToMain", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let todoListViewController = segue.destination as! ToDoListTableViewController
        if (todoListViewController.addEdit){
            todoListViewController.taskList.append(Task(name: task.name, description: task.description))
        } else {
            todoListViewController.didEditTask(task)
        }
    }
}



extension AddEditViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell")
            if let unwrappedCell = cell {
                
                let nameCell = unwrappedCell as! NameTableViewCell
                nameCell.delegate = self
                nameCell.textField.text = task.name
                
                return unwrappedCell
            }
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell")
            
            if let unwrappedCell = cell {
                let descriptionCell = unwrappedCell as! DescriptionTableViewCell
                descriptionCell.delegate = self
                descriptionCell.textView.text = task.description
                
                return unwrappedCell
            }
            
        }
        
        return UITableViewCell()
    }
}

extension AddEditViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Where 1 is index of DescriptionCell
        if indexPath.row == 0{
            return 100
        } else if indexPath.row == 1 {
            return 300
        } else {
            return 50
        }
    }
}

extension AddEditViewController: CellDelegate {
    
    func textFieldDidChange(value text: String) {
       task.name = text
    }
    
    func texViewDidChange(value text: String) {
        task.description = text
    }
    
}
