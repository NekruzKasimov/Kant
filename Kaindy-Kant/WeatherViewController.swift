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
    let weekdays = ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"]

    var week: [String] = []
    var dates: [Int] = []
    var degrees: [[Int]] = [[]]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Погода"
        self.navigationController?.navigationBar.topItem?.title = ""
//        weatherDegreeLabel.text = degrees[0][0] > 0 ? "+\(degrees[0][0])°C" : "\(degrees[0][0])°C"
//        weatheStatusLabel.text = weather?.list.array[0].weatherStatuses.array[0].main
    }
}

//MARK: UICollectionViewDataSourse, UICollectionViewDelegate methods

extension WeatherViewController {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return week.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
//        cell.weatherDegreeLabel.text =  degrees[indexPath.row][0] > 0 ? "+\(degrees[indexPath.row][0])°C" : "\(degrees[indexPath.row][0])°C"
//        cell.nightWeatherDegreeLabel.text = degrees[indexPath.row][1] > 0 ? "+\(degrees[indexPath.row][1])°C" : "\(degrees[indexPath.row][1])°C"
        cell.weekdayLabel.text = week[indexPath.row]
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
            let day = Calendar.current.component(.day, from: i.date)
            if hour == 3 {
//                let weekday = Calendar.current.component(.weekday, from: i.date)
//                week.append(weekdays[weekday - 1])
                temp.append(Int(i.main.temp))
                dates.append(day)
            } else if hour == 15 {
                temp.append(Int(i.main.temp))
                degrees.append(temp)
                temp = []
                let weekday = Calendar.current.component(.weekday, from: i.date)
                week.append(weekdays[weekday - 1])
            }
        }
    }

}
