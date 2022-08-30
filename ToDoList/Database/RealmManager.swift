//
//  RealmManager.swift
//  ToDoList
//
//  Created by admin on 18.08.22.
//

import Foundation
import RealmSwift

class RealmManager {
    
    let realm = try! Realm()
    
    func save(_ object: ToDoModelRealm) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func saveProduct(_ object: ProductModelRealm) {
        try! realm.write{
            realm.add(object)
        }
    }
    
    func getTasks() -> [ToDoModel] {
        let realmData = realm.objects(ToDoModelRealm.self)
        var tasks = [ToDoModel]()
        for task in realmData {
            tasks.append(ToDoModel(task: task))
        }
        return tasks
    }
    
    func getProduct() ->[ProductModel] {
        let realmData = realm.objects(ProductModelRealm.self)
        var products = [ProductModel]()
        for product in realmData {
            products.append(ProductModel(id: product.id, name: product.name, count: product.count, price: product.price, cathegory: ProductCathegory(rawValue: product.cathegory)!, measure: product.measure))
        }
        return products
    }
    
    
    func updateTaskStatus(id: String, isDone:Bool) {
        guard let taskToUpdate = realm.object(ofType: ToDoModelRealm.self, forPrimaryKey: id) else {return}
        try! realm.write {
            taskToUpdate.isDone = isDone
        }
    }
    
    func deleteTask(id: String) {
        guard let deleteTask = realm.object(ofType: ToDoModelRealm.self, forPrimaryKey: id) else {return}
        try! realm.write {
            realm.delete(deleteTask)
        }
    }
    
    func deleteProduct(id: String) {
        guard let deletePpoduct = realm.object(ofType: ProductModelRealm.self, forPrimaryKey: id) else {return}
        try! realm.write {
            realm.delete(deletePpoduct) 
        }
    }
    
}
