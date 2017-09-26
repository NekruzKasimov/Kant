//
//  CalculatorExcelTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/24/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class CalculatorExcelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var counterLabel: UILabel! {
        didSet {
            counterLabel.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var priceTF: UITextField! {
        didSet {
            priceTF.keyboardType = .decimalPad
        }
    }
    
    @IBOutlet weak var amountTF: UITextField! {
        didSet {
            amountTF.keyboardType = .decimalPad
        }
    }
    
    @IBOutlet weak var totalLabel: UILabel! {
        didSet {
            totalLabel.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var priceWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var amountWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var totalWidthConstraint: NSLayoutConstraint!
    
    func setConstraints(width: CGFloat) {
        priceWidthConstraint.constant        = width
        amountWidthConstraint.constant      = width
        totalWidthConstraint.constant       = width
    }
    
}
