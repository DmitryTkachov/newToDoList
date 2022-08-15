//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by admin on 11.08.22.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var addTaskTF: UITextField!
    
    var clousure: ((ToDoModel) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTaskButton(_ sender: Any) {
        guard let text = addTaskTF.text, text.count > 0 else {return}
        let toDoModel = ToDoModel(task: text, isDone: false)
        clousure?(toDoModel)
        navigationController?.popViewController(animated: true)
    }
    

}
