//
//  SugarAndJomTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/10/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class SugarAndJomTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView! {
        didSet {
            cardView.layer.cornerRadius = 3
            cardView.layer.masksToBounds = false
            cardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cardView.layer.shadowOpacity = 0.8
        }
    }
    
    @IBOutlet weak var sugarDateLabel: UILabel!
    @IBOutlet weak var jomDateLabel: UILabel!
    
    @IBOutlet weak var sugarPriceLabelUFO: UILabel!
    @IBOutlet weak var sugarPriceLabelCFO: UILabel!
    
    @IBOutlet weak var sugarPercentageLabelUFO: UILabel!
    @IBOutlet weak var sugarPercentageLabelCFO: UILabel!
    
    @IBOutlet weak var jomPriceLabelUFO: UILabel!
    @IBOutlet weak var jomPriceLabelCFO: UILabel!
    
    @IBOutlet weak var jomPercentageLabelUFO: UILabel!
    @IBOutlet weak var jomPercentageLabelCFO: UILabel!

    func setSugarValues(sugar: Sugar){
        if sugar.name == "CFO" {
            sugarPriceLabelCFO.text = sugar.price
            sugarPercentageLabelCFO.text = sugar.percentage
        } else {
            sugarPriceLabelUFO.text = sugar.price
            sugarPercentageLabelUFO.text = sugar.percentage
        }
        sugarDateLabel.text = "\(Constants.SugarAndJom.SugarDate) \(sugar.date)"
    }

    func setJomValue(jom: Jom){
        if jom.name == "CFO" {
            jomPriceLabelCFO.text = jom.price
            jomPercentageLabelCFO.text = jom.percentage
        } else {
            jomPriceLabelUFO.text = jom.price
            jomPercentageLabelUFO.text = jom.percentage
        }
        sugarDateLabel.text = "\(Constants.SugarAndJom.JomDate) \(jom.date)"
    }
    
    func setValues(sugarJom: SugarJom) {
        for sugar in sugarJom.sugar.array {
            setSugarValues(sugar: sugar)
        }
        for jom in sugarJom.jom.array {
            setJomValue(jom: jom)
        }
    }
}
