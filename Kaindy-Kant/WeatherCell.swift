//
//  WeatherCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/22/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    
    @IBOutlet weak var weekdayLabel: UILabel!
    
    @IBOutlet weak var nightWeatherDegreeLabel: UILabel!

    func setValues(week: String, degrees: [Int]){
        weatherDegreeLabel.text =  degrees[0] > 0 ? "+\(degrees[0])°C" : "\(degrees[0])°C"
        nightWeatherDegreeLabel.text = degrees[1] > 0 ? "+\(degrees[1])°C" : "\(degrees[1])°C"
        weekdayLabel.text = week
    }

}
