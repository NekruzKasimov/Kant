//
//  WeatherCollectionViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/18/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation


class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!  {
        didSet {
            cardView.layer.cornerRadius = 3
            cardView.layer.masksToBounds = false
            cardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cardView.layer.shadowOpacity = 0.8
        }
    }

}
