//
//  CustomSensorCell.swift
//  smartCity
//
//  Created by shick on 30.05.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit

class CustomSensorCell: UITableViewCell {

    
    @IBOutlet weak var sensorImageCell: UIImageView!
    @IBOutlet weak var sensorNameCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
