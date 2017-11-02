//
//  ExcelTotalTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/24/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class ExcelTotalTableViewCell: UITableViewCell, UpdateTotalValueDelegate {
    
    func updateTotalValue(total: Int) {
        totalLabel.text = "\(total)"
        reloadInputViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CalculatorExcelLogicController.shared.delegate = self
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel! 

}
