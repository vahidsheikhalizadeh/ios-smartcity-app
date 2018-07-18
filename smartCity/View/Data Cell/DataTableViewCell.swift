//
//  DataTableViewCell.swift
//  smartCity
//
//  Created by shick on 18.07.18.
//  Copyright © 2018 vahid. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var sensorDataImage: UIImageView!
    
    @IBOutlet weak var sensorDataValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
