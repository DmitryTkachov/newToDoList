//
//  ToDoModel.swift
//  ToDoList
//
//  Created by artsiom on 9.08.22.
//

import Foundation

struct ToDoModel {
	let task: String
	var isDone: Bool
    let dedlineDate: Date
    init(task: String, isDone: Bool, dedlineDate: Date) {
		self.task = task
		self.isDone = isDone
        self.dedlineDate = dedlineDate
	}
}

