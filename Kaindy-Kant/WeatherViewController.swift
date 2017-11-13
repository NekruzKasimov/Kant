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
    
    var weekdays = [String]()
    var dates: [Int] = []
    var degrees: [[Int]] = []
    var statusToday = ""
    var degreeToday = ""
    var month: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWeatherDegree()
        self.title = "Погода"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}

//MARK: UICollectionViewDataSourse, UICollectionViewDelegate methods

extension WeatherViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.setValues(week: self.weekdays[indexPath.row], degrees: degrees[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(100)
        let width = (collectionView.frame.width - 25) / 5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
//MARK: Helper functions

extension WeatherViewController {
    
    func updateValues() {
        for item in (weather?.list.array)!{
            let weekday = Calendar.current.component(.weekday, from: item.date)
            let day = Calendar.current.component(.day, from: item.date)
            var temp: [Int] = []
            temp.append(Int(item.temp.max)!)
            temp.append(Int(item.temp.min)!)
            degrees.append(temp)
            dates.append(day)
            weekdays.append(Constants.Weather.weekdays[weekday - 1])
        }
        let currentDate = Date()
        statusToday = Constants.Weather.weatherStatuses[(weather?.today.array[0].type)!]!
        degreeToday = (weather?.today.array[0].temp)!
        month = Constants.Weather.months[Calendar.current.component(.month, from: (weather?.today.array[0].exact_time)!)]
        for item in (weather?.today.array)! {
            switch currentDate.compare(item.exact_time) {
            case .orderedAscending:
                statusToday = Constants.Weather.weatherStatuses[item.type]!
                degreeToday = item.temp
                month = Constants.Weather.months[Calendar.current.component(.month, from: item.exact_time)]
            default:
                break
            }
        }
    }
    
    func setWeatherDegree() {
        self.weatherDegreeLabel.text = Int(degreeToday)! > 0 ? "+\(degreeToday)!)°C" : "\(degreeToday)°C"
        self.weatheStatusLabel.text = statusToday
        self.dateLabel.text = "\(weekdays[0]), \(dates[0]) \(month)"
    }
}
