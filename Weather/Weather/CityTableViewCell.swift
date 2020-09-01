//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Tony Jung on 2020/08/25.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var cityImg: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var celsius: UILabel!
    @IBOutlet weak var fahrenheit: UILabel!
    @IBOutlet weak var rainfall: UILabel!
    
   // @IBOutlet weak var cityName:
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
