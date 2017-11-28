//
//  IncomeAndProfitTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 11/27/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class ProfitTableViewCell: UITableViewCell, ProfitDelegate {
    
    let lang = DataManager.shared.getLanguage()
    
    func updateProfitData() {
        let shared = CalculatorExcelLogicController.shared
        resultLabel.text = "\(shared.income) - \(shared.totalValue) = \(shared.income - shared.totalValue)"
        reloadInputViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CalculatorExcelLogicController.shared.profitDelegate = self
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "profit".localized(lang: lang)
        }
    }
    
    @IBOutlet weak var resultLabel: UILabel! {
        didSet {
            resultLabel.textColor = UIColor.init(netHex: Colors.purple)
        }
    }
}

