//
//  ViewController.swift
//  ToDoList
//
//  Created by artsiom on 9.08.22.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    private let realmManager = RealmManager()
    var allTasks: [[ToDoModel]] = [[], []]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTabBarAppearence()
    }
    
    func setupTabBarAppearence() {
        self.tabBarController?.tabBar.layer.borderWidth = 0.5
        self.tabBarController?.tabBar.layer.borderColor = UIColor.black.cgColor
        self.tabBarController?.tabBar.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readToDos()
    }
    
    func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let toDoCell = UINib(nibName: "ToDoCell", bundle: nil)
        tableView.register(toDoCell, forCellReuseIdentifier: "todocell")
        
        tableView.allowsSelectionDuringEditing = true
    }
    
    func readToDos() {
        let unsortedTask = realmManager.getTasks()
        allTasks[0] = unsortedTask.filter({ model in
            !model.isDone
        })
        allTasks[1] = unsortedTask.filter({ model in
            model.isDone
        })
        
        tableView.reloadData()
    }
    
    func changeStatus(id: String, isDone:Bool) {
        realmManager.updateTaskStatus(id: id, isDone: isDone)
    }
    
    func deleteTask(from section: Int, _ row: Int) {
        realmManager.deleteTask(id: allTasks[section][row].id)
        allTasks[section].remove(at: row)
        tableView.reloadData()
    }
    
    func undoneTask(at section: Int, _ row: Int) {
        self.allTasks[section][row].isDone = false
        let undoneTask = self.allTasks[section][row]
        self.changeStatus(id: undoneTask.id, isDone: false)
        self.allTasks[section].remove(at: row)
        self.allTasks[0].append(undoneTask)
        self.tableView.reloadData()
    }
    
    @IBAction func editMode(_ sender: Any) {
        tableView.isEditing.toggle()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(identifier: "AddTaskViewController") as? AddTaskViewController else {return}
        navigationController?.pushViewController(destination, animated: true)
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        allTasks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "pending tasks" : "done tasks"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allTasks[section].count
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
        60
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {return}
        
        var doneTask = allTasks[indexPath.section][indexPath.row]
        doneTask.isDone = true
        changeStatus(id: doneTask.id, isDone: true)
        
        allTasks[indexPath.section].remove(at: indexPath.row)
        
        allTasks[1].append(doneTask)
        
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        var moveCell = allTasks[sourceIndexPath.section][sourceIndexPath.row]
        if sourceIndexPath.section != destinationIndexPath.section {
            moveCell.isDone.toggle()
            changeStatus(id: moveCell.id, isDone: false)
        }
        allTasks[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        allTasks[destinationIndexPath.section].insert(moveCell, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let undoneAction = UIContextualAction(style: .normal, title: "UnDone") { _, _, completion in
            self.undoneTask(at: indexPath.section, indexPath.row)
            completion(true)
        }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            self.deleteTask(from: indexPath.section, indexPath.row)
            completion(true)
        }
        
        undoneAction.backgroundColor = .systemBlue
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: indexPath.section == 0 ? [deleteAction] : [undoneAction, deleteAction])
    }
}

