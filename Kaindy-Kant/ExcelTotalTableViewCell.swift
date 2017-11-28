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
    
    let lang = DataManager.shared.getLanguage()
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "total_sum".localized(lang: lang)
        }
    }
    
    @IBOutlet weak var totalLabel: UILabel!  {
        didSet {
            totalLabel.textColor = UIColor.init(netHex: Colors.purple)
        }
    }

}
