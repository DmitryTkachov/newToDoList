//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by admin on 11.08.22.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var addTaskTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var clousure: ((ToDoModel) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
    }
    func setupDatePicker() {
        datePicker.minimumDate = Date()
    }
    
    @IBAction func addTaskButton(_ sender: Any) {
        guard let text = addTaskTF.text, text.count > 0 else {return}
        let toDoModel = ToDoModel(task: text, isDone: false, dedlineDate: datePicker.date)
        clousure?(toDoModel)
        navigationController?.popViewController(animated: true)
    }
    

}
