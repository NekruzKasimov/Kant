//
//  IncomeAndProfitTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 11/27/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class IncomeTableViewCell: UITableViewCell, IncomeDelegate {
    
    let lang = DataManager.shared.getLanguage()
    
    func updateIncomeData() {
        let shared = CalculatorExcelLogicController.shared
        resultLabel.text = "\(shared.harvest) * \(shared.valueOfProduct) = \(shared.harvest * Double(shared.valueOfProduct))"
        CalculatorExcelLogicController.shared.income = Int(shared.harvest * Double(shared.valueOfProduct))
        reloadInputViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CalculatorExcelLogicController.shared.incomeDelegate = self
    }
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.text = "income".localized(lang: lang)
        }
    }
    
    @IBOutlet weak var resultLabel: UILabel! {
        didSet {
            resultLabel.textColor = UIColor.init(netHex: Colors.purple)
        }
    }
}
