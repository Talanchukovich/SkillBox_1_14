//
//  DaysCell2.swift
//  homeWork12
//
//  Created by Андрей Таланчук on 20.01.2021.
//

import UIKit

class DaysCell2: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
    
        dateLabel2.text = nil
        descriptionImage2.image = nil
        temp_maxLabel2.text = nil
        temp_minLabel2.text = nil
        
    }
    
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet weak var descriptionImage2: UIImageView!
    @IBOutlet weak var temp_maxLabel2: UILabel!
    @IBOutlet weak var temp_minLabel2: UILabel!
    
}
