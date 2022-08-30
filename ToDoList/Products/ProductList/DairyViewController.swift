//
//  DairyViewController.swift
//  ToDoList
//
//  Created by admin on 23.08.22.
//

import UIKit
import RealmSwift

class DairyViewController: UIViewController {
    
    private let realmManager = RealmManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var trashButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashButtonPressed))
    lazy var cancelButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
    lazy var doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
    lazy var addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    
    var products: [ProductModel] = []
    var isDelitingMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        enableDeletingMode(enable: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readDairyModel()
    }
    
    func readDairyModel() {
        products = realmManager.getProduct()
        self.collectionView.reloadData()
    }
    
    @objc func addButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(identifier: "AddProductViewController") as? AddProductViewController else {return}
        navigationController?.pushViewController(destination, animated: true)
    }
    
    @objc func trashButtonPressed() {
        enableDeletingMode(enable: true)
    }
    
    @objc func cancelButtonPressed() {
        enableDeletingMode(enable: false)
        for index in 0...(products.count - 1) {  //Ругается на индекс при пустом массиве
            products[index].isSelected = false
        }
        self.collectionView.reloadData()
    }
    
    @objc func doneButtonPressed() {
        deleteProductCell()
        cancelButtonPressed()
    }
    
    func deleteProductCell() {
        for product in products {
            if product.isSelected == true {
                products.removeAll { model in model.isSelected}
                realmManager.deleteProduct(id: product.id)
            }
        }
    }
    
    func enableDeletingMode(enable: Bool) {
        self.navigationItem.rightBarButtonItem = enable ? doneButton : addButton
        self.navigationItem.leftBarButtonItem = enable ? cancelButton : trashButton
        isDelitingMode = enable
    }
    
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let productCell = UINib(nibName: "ProductCell", bundle: nil)
        collectionView.register(productCell, forCellWithReuseIdentifier: "ProductCell")
    }
}

extension DairyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        cell.setup(with: products[indexPath.row])
        return cell
    }
}

extension DairyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard isDelitingMode else {return}
        products[indexPath.row].isSelected.toggle()
        collectionView.reloadItems(at: [indexPath])
    }
}

extension DairyViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.width / 2) - 8, height: 60)
    }
    
    
    
    
}
