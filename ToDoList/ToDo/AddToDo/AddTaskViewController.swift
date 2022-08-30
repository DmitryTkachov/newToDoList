//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by admin on 11.08.22.
//

import UIKit
import RealmSwift

class AddTaskViewController: UIViewController {

    private let realmManager = RealmManager()

    
    @IBOutlet weak var addTaskTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
    }
    
    func setupDatePicker() {
        datePicker.minimumDate = Date()
    }
    
    @IBAction func addTaskButton(_ sender: Any) {
        createRealmObject()
        navigationController?.popViewController(animated: true)
    }
    
    func createRealmObject() {
        guard let text = addTaskTF.text, text.count > 0 else {return}
        realmManager.save(ToDoModelRealm.create(task: text, isDone: false, dedlineDate: datePicker.date))
        }
    }

