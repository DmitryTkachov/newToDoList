//
//  AddProductViewController.swift
//  ToDoList
//
//  Created by admin on 23.08.22.
//

import UIKit
import RealmSwift

class AddProductViewController: UIViewController {
    
    private let realmManager = RealmManager()
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var countLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var measureLabel: UITextField!
    
    @IBOutlet weak var cathegoryLabel: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addProductButton(_ sender: Any) {
        createProductRealm()
        navigationController?.popViewController(animated: true)
        
    }
    
    func createProductRealm() {
        
        guard let name = nameLabel.text,
              let countString = countLabel.text,
              let count = Int(countString),
              let measure = measureLabel.text,
              let priceString = priceLabel.text,
              let price = Double(priceString) else {return}
        
        let cathegory: ProductCathegory
        switch cathegoryLabel.selectedSegmentIndex {
        case 0:
            cathegory = .dairy
        case 1:
            cathegory = .meat
        case 2:
            cathegory = .drink
        case 3:
            cathegory = .eat
        default:
            cathegory = .dairy
        }
        
        realmManager.saveProduct(ProductModelRealm.create(name: name, count: count, price: Int(price)*100, cathegory: cathegory, measure: measure))
    }
}
