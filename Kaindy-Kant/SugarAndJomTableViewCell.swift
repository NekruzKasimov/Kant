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
}
