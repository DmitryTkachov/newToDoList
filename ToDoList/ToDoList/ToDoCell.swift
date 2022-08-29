//
//  ToDoCell.swift
//  ToDoList
//
//  Created by artsiom on 9.08.22.
//

import UIKit

class ToDoCell: UITableViewCell {

	@IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func setup(task: ToDoModel) {
        taskLabel.text = task.task
        iconImageView.isHidden = !task.isDone
        setDateInLabel(task.dedlineDate)
	}
    
    func setDateInLabel(_ date: Date) {
        let dateFormater = DateFormatter()
        
//        dateFormater.dateStyle = .long
//        dateFormater.timeStyle = .short
        dateFormater.dateFormat = "HH:mm E, d MMM y"
        
        dateLabel.text = dateFormater.string(from: date)
        
    }
}
