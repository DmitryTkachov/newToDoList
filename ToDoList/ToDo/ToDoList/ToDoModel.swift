import Foundation
import RealmSwift

struct ToDoModel {
    let id: String
	let task: String
	var isDone: Bool
    let dedlineDate: Date
    
    init(id: String, task: String, isDone: Bool, dedlineDate: Date) {
		self.task = task
		self.isDone = isDone
        self.dedlineDate = dedlineDate
        self.id = id
	}
    
    init(task: ToDoModelRealm) {
        self.id = task.id
        self.task = task.task
        self.isDone = task.isDone
        self.dedlineDate = task.dedlineDate
    }
}

class ToDoModelRealm: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var task: String = " "
    @objc dynamic var isDone: Bool = false
    @objc dynamic var dedlineDate: Date = Date()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func create (task: String, isDone: Bool, dedlineDate: Date) -> ToDoModelRealm {
        let model = ToDoModelRealm()
        model.task = task
        model.dedlineDate = dedlineDate
        model.isDone = isDone
        return model
        
    }
}
