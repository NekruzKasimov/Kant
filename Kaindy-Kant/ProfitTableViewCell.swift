//
//  IncomeAndProfitTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 11/27/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class ProfitTableViewCell: UITableViewCell, ProfitDelegate {
    func updateProfitData() {
        let shared = CalculatorExcelLogicController.shared
        resultLabel.text = "\(shared.income) - \(shared.totalValue) = \(shared.income - shared.totalValue)"
        reloadInputViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CalculatorExcelLogicController.shared.profitDelegate = self
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
}

