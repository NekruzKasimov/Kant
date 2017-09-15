//
//  FirstSectionTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/8/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import UIKit

class FirstSectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    @IBOutlet weak var dollarPriceLabel: UILabel!
    @IBOutlet weak var euroPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        getWeather()
    }
    
    func getWeather() {
        
        let url = URL(string: "http://api.apixu.com/v1/current.json?key=caaccff481a54ae295f113008171409&q=Bishkek")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                if let content = data {
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
//                        if let location = myJson["location"] as? NSDictionary {
//                            if let name = location["name"] {
//                                self.cityNameLbl.text = "\(name)"
//                                print(name)
//                            }
//                        }
                        
                        if let current = myJson["current"] as? NSDictionary {
                            if let temp = current["temp_c"] {
                                self.weatherDegreeLabel.text = "\(temp)°C"
                            }
                        }
                    } catch {
                        
                    }
                }
            }
        }
        task.resume()
    }
}
