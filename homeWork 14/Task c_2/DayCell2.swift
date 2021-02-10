//
//  DayCell2.swift
//  homeWork12
//
//  Created by Андрей Таланчук on 20.01.2021.
//

import UIKit

class DayCell2: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        nameLabel2.text = nil
        descriptionLabel2.text = nil
        tempLabel2.text = nil
        feelsLikeLabel2.text = nil
        minMaxTempLabel2.text = nil
    }
    
    @IBOutlet weak var nameLabel2: UILabel!
    @IBOutlet weak var descriptionLabel2: UILabel!
    @IBOutlet weak var tempLabel2: UILabel!
    @IBOutlet weak var feelsLikeLabel2: UILabel!
    @IBOutlet weak var minMaxTempLabel2: UILabel!
    
}
