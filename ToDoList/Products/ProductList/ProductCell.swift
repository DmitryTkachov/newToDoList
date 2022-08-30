//
//  ProductCell.swift
//  ToDoList
//
//  Created by admin on 23.08.22.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var selectionView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionView.isHidden = true
    }

    func setup(with model: ProductModel) {
        nameLabel.text = model.name
        countLabel.text = String(model.count) + " " + model.measure
        
        let price: Double = Double(model.price) / 100
        
        priceLabel.text = String(format: "%.2f", price)
        containerView.backgroundColor = model.cathegory.getColour()
        setupRounding()
        
        selectionView.isHidden = !model.isSelected
    }
    
    func setupRounding() {
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 10
    }
}
