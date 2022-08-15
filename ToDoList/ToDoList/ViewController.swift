//
//  ViewController.swift
//  ToDoList
//
//  Created by artsiom on 9.08.22.
//

import UIKit

class ViewController: UIViewController {
    
    var tasks = [
        ToDoModel(task: "1", isDone: false),
        ToDoModel(task: "2", isDone: false),
        ToDoModel(task: "3", isDone: false),
        ToDoModel(task: "4", isDone: false)
    ]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let toDoCell = UINib(nibName: "ToDoCell", bundle: nil)
        tableView.register(toDoCell, forCellReuseIdentifier: "todocell")
        
        tableView.allowsSelectionDuringEditing = true
    }
    
    @IBAction func editMode(_ sender: Any) {
        tableView.isEditing.toggle()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(identifier: "AddTaskViewController") as? AddTaskViewController else {return}
        navigationController?.pushViewController(destination, animated: true)
        
        destination.clousure = { model in
            self.tasks.append(model)
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todocell", for: indexPath) as? ToDoCell
        else {
            return UITableViewCell()
        }
        cell.setup(task: tasks[indexPath.row])
        return cell
    }
//---------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if tasks[section].isDone == true {
                return "is Done"
            } else { return "not Done" }
    }
    
//---------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.none
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasks[indexPath.row].isDone = true
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let mooveObject = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(mooveObject, at: destinationIndexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let undoneAction = UIContextualAction(style: .normal, title: "UnDone") { _, _, completion in
            self.tasks[indexPath.row].isDone = false
            self.tableView.reloadData()
            completion(true)
        }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            self.tasks.remove(at: indexPath.row)
            self.tableView.reloadData()
            completion(true)
        }
        
        
        undoneAction.backgroundColor = .systemBlue
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [undoneAction, deleteAction])
    }
    
}

