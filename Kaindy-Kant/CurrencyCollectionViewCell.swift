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
    
    
    func setValues(currencies: [Currency]){
        print(currencies.count)
        
        rub_buy.text = currencies[2].rates.buy_rate
        rub_sell.text = currencies[2].rates.sell_rate
        usd_buy.text = currencies[0].rates.buy_rate
        usd_sell.text = currencies[0].rates.sell_rate
        eur_buy.text = currencies[1].rates.buy_rate
        eur_sell.text = currencies[1].rates.sell_rate
        kzt_buy.text = currencies[3].rates.buy_rate
        kzt_sell.text = currencies[3].rates.sell_rate
        
    }
    
}
