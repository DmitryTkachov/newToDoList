import Foundation
import UIKit
import RealmSwift

enum ProductCathegory: String {
    case dairy
    case meat
    case drink
    case eat
    
    func getColour() -> UIColor? {
        switch self {
        case .dairy:
            return UIColor(named: "Dairy")
        case .meat:
            return UIColor(named: "Meat")
        case .drink:
            return UIColor(named: "Drink")
        case .eat:
            return .orange
        }
    }
}

struct ProductModel {
    let id: String
    let name: String
    let count: Int
    let price: Int
    let cathegory: ProductCathegory
    let measure: String
    
    var isSelected: Bool = false
}

class ProductModelRealm: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var count: Int = 0
    @objc dynamic var price: Int = 0
    @objc dynamic var cathegory: String = ""
    @objc dynamic var measure: String = ""
    @objc dynamic var id: String = UUID().uuidString
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func create(name: String, count: Int, price: Int, cathegory: ProductCathegory, measure: String) -> ProductModelRealm {
        let realmModel = ProductModelRealm()
        realmModel.name = name
        realmModel.count = count
        realmModel.price = price
        realmModel.cathegory = cathegory.rawValue
        realmModel.measure = measure
        
        return realmModel
        
    }
    
}

