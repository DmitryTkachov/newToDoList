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
        
// Форматы времени:
//        Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
//        09/12/2018                        --> MM/dd/yyyy
//        09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
//        Sep 12, 2:11 PM                   --> MMM d, h:mm a
//        September 2018                    --> MMMM yyyy
//        Sep 12, 2018                      --> MMM d, yyyy
//        Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
//        2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
//        12.09.18                          --> dd.MM.yy
//        10:41:02.112                      --> HH:mm:ss.SSS
        
        dateLabel.text = dateFormater.string(from: date)
        
    }
}
