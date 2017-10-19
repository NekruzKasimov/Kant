//
//  WeatherViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/22/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
   

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    @IBOutlet weak var weatheStatusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var collectionView: UICollectionView!

    var weather: Weather? {
        didSet {
            updateValues()
        }
    }
    
    var week: [String] = []
    var dates: [Int] = []
    var months: [String] = []
    var degrees: [[Int]] = []
    var status = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setWeatherDegree()
        self.title = "Погода"
    }
}

//MARK: UICollectionViewDataSourse, UICollectionViewDelegate methods

extension WeatherViewController {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.setValues(week: week[indexPath.row], degrees: degrees[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(100)
        let width = (collectionView.frame.width - 25) / 5
        return CGSize(width: width, height: height)
    }
}
//MARK: Helper functions

extension WeatherViewController {
    
    func updateValues() {
        var temp: [Int] = []
        for i in (weather?.list.array)! {
            let hour = Calendar.current.component(.hour, from: i.date)
            if hour == 15 {
                let day = Calendar.current.component(.day, from: i.date)
                let weekday = Calendar.current.component(.weekday, from: i.date)
                let month = Calendar.current.component(.month, from: i.date)
                week.append(Constants.Weather.weekdays[weekday - 1])
                temp.append(Int(i.main.temp))
                dates.append(day)
                months.append(Constants.Weather.months[month - 1])
                if let item = Constants.Weather.weatherStatuses[i.weatherStatuses.array[0].main] {
                    self.status = item
                }
            } else if hour == 3 {
                temp.append(Int(i.main.temp))
                degrees.append(temp)
                temp.removeAll()
            }
        }
    }

    func setWeatherDegree() {
        self.weatherDegreeLabel.text = degrees[0][0] > 0 ? "+\(degrees[0][0])°C" : "\(degrees[0][0])°C"
        self.weatheStatusLabel.text = status
        self.dateLabel.text = "\(week[0]), \(dates[0]) \(months[0])"
    }
}
