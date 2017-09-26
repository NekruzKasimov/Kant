//
//  ExcelTotalTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/24/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class ExcelTotalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var totalLabel: UILabel! {
        didSet {
            totalLabel.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var totalWidthConstraint: NSLayoutConstraint!
    
    func setConstraints(width: CGFloat) {
        totalWidthConstraint.constant       = width
    }
}
