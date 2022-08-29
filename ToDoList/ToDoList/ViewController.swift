//
//  ViewController.swift
//  ToDoList
//
//  Created by artsiom on 9.08.22.
//

import UIKit

class ViewController: UIViewController {
    

    var allTasks: [[ToDoModel]] = [[], []]
    
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
            self.allTasks[0].append(model)
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return allTasks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "pending tasks"
        } else {
            return "done tasks"
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasks[section].count //(tasks.count + done.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todocell", for: indexPath) as? ToDoCell
        else {
            return UITableViewCell()
        }
        cell.setup(task: allTasks[indexPath.section][indexPath.row]) //(tasks + done)[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

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
        if indexPath.section != 0 {return}
        var doneTask = allTasks[indexPath.section][indexPath.row]
        doneTask.isDone = true
        
        allTasks[indexPath.section].remove(at: indexPath.row)
        
        allTasks[1].append(doneTask)
        
        tableView.reloadData()

    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        var moveCell = allTasks[sourceIndexPath.section][sourceIndexPath.row]
        if sourceIndexPath.section != destinationIndexPath.section {
            moveCell.isDone.toggle()
        }
        allTasks[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        allTasks[destinationIndexPath.section].insert(moveCell, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let undoneAction = UIContextualAction(style: .normal, title: "UnDone") { _, _, completion in
            self.allTasks[indexPath.section][indexPath.row].isDone = false
            let undoneTask = self.allTasks[indexPath.section][indexPath.row]
            self.allTasks[indexPath.section].remove(at: indexPath.row)
            self.allTasks[0].append(undoneTask)
            self.tableView.reloadData()
            completion(true)
        }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            self.allTasks[indexPath.section].remove(at: indexPath.row)
            self.tableView.reloadData()
            completion(true)
        }
        
        
        undoneAction.backgroundColor = .systemBlue
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: indexPath.section == 0 ? [deleteAction] : [undoneAction, deleteAction])
    }
    
}

