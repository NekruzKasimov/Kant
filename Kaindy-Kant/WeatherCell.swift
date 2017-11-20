//
//  WeatherCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/22/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class WeatherCell: UICollectionViewCell {
    
    let lang = DataManager.shared.getLanguage()
    
    @IBOutlet weak var cardView: UIView!  {
        didSet {
            cardView.layer.cornerRadius = 3
            cardView.layer.masksToBounds = false
            cardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cardView.layer.shadowOpacity = 0.8
        }
    }
    
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    
    @IBOutlet weak var weekdayLabel: UILabel!
    
    @IBOutlet weak var nightWeatherDegreeLabel: UILabel!

    @IBOutlet weak var dayLabel: UILabel! {
        didSet {
            dayLabel.text = "day".localized(lang: lang)
        }
    }
    
    @IBOutlet weak var nightLabel: UILabel! {
        didSet {
            nightLabel.text = "night".localized(lang: lang)
        }
    }
    
    func setValues(week: String, degrees: [Int]){
        weatherDegreeLabel.text =  degrees[0] > 0 ? "+\(degrees[0])°C" : "\(degrees[0])°C"
        nightWeatherDegreeLabel.text = degrees[1] > 0 ? "+\(degrees[1])°C" : "\(degrees[1])°C"
        weekdayLabel.text = week
    }

}
