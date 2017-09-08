//
//  FirstSectionTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/8/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import UIKit

class FirstSectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    @IBOutlet weak var dollarPriceLabel: UILabel!
    @IBOutlet weak var euroPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
