//
//  FirstSectionTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/26/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class FirstSectionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var firstLabel: UILabel! {
        didSet {
            firstLabel.layer.borderWidth = 1
            firstLabel.backgroundColor = UIColor.init(netHex: Colors.gray)
        }
    }
    
    @IBOutlet weak var typesOfJobLabel: UILabel! {
        didSet {
            typesOfJobLabel.layer.borderWidth = 1
            typesOfJobLabel.backgroundColor = UIColor.init(netHex: Colors.gray)
        }
    }
    
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.layer.borderWidth = 1
            priceLabel.backgroundColor = UIColor.init(netHex: Colors.gray)
        }
    }
    
    @IBOutlet weak var amountLabel: UILabel! {
        didSet {
            amountLabel.layer.borderWidth = 1
            amountLabel.backgroundColor = UIColor.init(netHex: Colors.gray)
        }
    }
    
    @IBOutlet weak var totalPriceLabel: UILabel! {
        didSet {
            totalPriceLabel.layer.borderWidth = 1
            totalPriceLabel.backgroundColor = UIColor.init(netHex: Colors.gray)
        }
    }
    
}
