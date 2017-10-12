//
//  CurrencyCollectionViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/18/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation


class CurrencyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!  {
        didSet {
            cardView.layer.cornerRadius = 3
            cardView.layer.masksToBounds = false
            cardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cardView.layer.shadowOpacity = 0.8
        }
    }

    @IBOutlet weak var rub_buy: UILabel!
    @IBOutlet weak var rub_sell: UILabel!
    @IBOutlet weak var usd_buy: UILabel!
    @IBOutlet weak var usd_sell: UILabel!
    @IBOutlet weak var eur_buy: UILabel!
    @IBOutlet weak var eur_sell: UILabel!
    @IBOutlet weak var kzt_buy: UILabel!
    @IBOutlet weak var kzt_sell: UILabel!
    
    
    
    
}
