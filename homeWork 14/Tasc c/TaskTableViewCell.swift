//
//  TaskTableViewCell.swift
//  homeWork 14
//
//  Created by Андрей Таланчук on 02.02.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
   
    override func prepareForReuse() {
        super.prepareForReuse()
        taskLabel.text = nil
        dateLabel.text = nil
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.taskLabel = nil
//    }

}
