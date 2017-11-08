//
//  FirstSectionTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/26/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class FirstSectionTableViewCell: UITableViewCell {
    
    let lang = DataManager.shared.getLanguage()
    
    @IBOutlet weak var firstLabel: UILabel!{
        didSet{
            firstLabel.text = "calculator_title".localized(lang: lang)
        }
    }
    
    @IBOutlet weak var typesOfJobLabel: UILabel! {
        didSet {
            typesOfJobLabel.text = "job_types".localized(lang: lang)
        }
    }
    
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.text = "cost".localized(lang: lang)
        }
    }
    
    @IBOutlet weak var amountLabel: UILabel! {
        didSet {
            amountLabel.text = "quantity".localized(lang: lang)
        }
    }
    
    @IBOutlet weak var totalPriceLabel: UILabel! {
        didSet {
            totalPriceLabel.text = "expenses".localized(lang: lang)
        }
    }
    
}
