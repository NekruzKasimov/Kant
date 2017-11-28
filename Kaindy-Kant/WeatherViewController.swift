//
//  WeatherViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/22/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class WeatherViewController: ViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    @IBOutlet weak var weatheStatusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var weekLabel: UILabel! {
        didSet {
            weekLabel.text = "week".localized(lang: self.lang)!
        }
    }
    @IBOutlet weak var iconImageView: UIImageView!
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
    var statusIcon = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWeatherDegree()
        self.title = "weather".localized(lang: self.lang)
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "weather".localized(lang: self.lang)
    }
}

//MARK: UICollectionViewDataSourse, UICollectionViewDelegate methods

extension WeatherViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let weekday = indexPath.row == 0 ? "today".localized(lang: self.lang)! : self.weekdays[indexPath.row]
        cell.setValues(week: weekday, degrees: degrees[indexPath.row])
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
        degreeToday = (weather?.today.array[0].temp)!
        let a = Calendar.current.component(.month, from: (weather?.today.array[0].exact_time)!)
        month = Constants.Weather.months[a]
        guard let type = Constants.Weather.weatherStatuses[(weather?.today.array[0].type)!] else {
            return
        }
        statusToday = type
        statusIcon = checkType(type: type)
//        for item in (weather?.today.array)! {
//            switch currentDate.compare(item.exact_time) {
//            case .orderedAscending:
//                let type = Constants.Weather.weatherStatuses[item.type]!
//                statusToday = type
//                checkType(type: type)
//                degreeToday = item.temp
//                month = Constants.Weather.months[Calendar.current.component(.month, from: item.exact_time)]
//            default:
//                break
//            }
//        }
    }
    
    func checkType(type: String) -> Int {
        switch type {
        case "Rain":
            return 1
        case "Cloudy", "Mostly cloudy" :
            return 2
        case "Clear":
            return 3
        case "Snow":
            return 4
        default:
            break
        }
        return 0
    }
    
    func setWeatherDegree() {
        switch statusIcon {
        case 1:
            iconImageView.image = #imageLiteral(resourceName: "rainy")
        case 2, 0:
            iconImageView.image = #imageLiteral(resourceName: "cloudy")
        case 3:
            iconImageView.image = #imageLiteral(resourceName: "sunny")
        case 4:
            iconImageView.image = #imageLiteral(resourceName: "snowy")
        default: break
        }
        
        self.weatherDegreeLabel.text = Int(degreeToday)! > 0 ? "+\(degreeToday)°C" : "\(degreeToday)°C"
        self.weatheStatusLabel.text = statusToday
        self.dateLabel.text = "\(weekdays[0]), \(dates[0]) \(month)"
    }
}
