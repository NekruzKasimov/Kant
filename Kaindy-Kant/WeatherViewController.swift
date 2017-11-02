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
    
    var week: Int = 0
    var dates: [Int] = []
    var month: String = ""
    var degrees: [[Int]] = []
    var status = ""
    
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
        let temp = (week + indexPath.row)
        let weekday = temp >= 7 ? (temp - 7) : temp
        cell.setValues(week: Constants.Weather.weekdays[weekday], degrees: degrees[indexPath.row])
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let today = dateFormatter.date(from: (weather?.list.array[0].date)!)
        week = Calendar.current.component(.weekday, from: today!) - 1
        let monthDate = Calendar.current.component(.month, from: today!)
        month = Constants.Weather.months[monthDate - 1]
        for item in (weather?.list.array)!{
            let date = dateFormatter.date(from: item.date)
//            let weekday = Calendar.current.component(.weekday, from: date!)
    
            let day = Calendar.current.component(.day, from: date!)
            var temp: [Int] = []
            temp.append(Int(item.temp.max)!)
            temp.append(Int(item.temp.min)!)
            degrees.append(temp)
            dates.append(day)
//            months.append(Constants.Weather.months[month - 1])
//            week.append(Constants.Weather.weekdays[weekday - 1])
            if let item = Constants.Weather.weatherStatuses[(weather?.today.array[0].type)!] {
                self.status = item
            }
        }
    }
    
    func setWeatherDegree() {
        self.weatherDegreeLabel.text = Int(weather!.today.array[0].temp)! > 0 ? "+\(Int(weather!.today.array[0].temp)!)°C" : "\(Int(weather!.today.array[0].temp)!)°C"
        self.weatheStatusLabel.text = status
        self.dateLabel.text = "\(Constants.Weather.weekdays[week]), \(dates[0]) \(month)"
    }
}
