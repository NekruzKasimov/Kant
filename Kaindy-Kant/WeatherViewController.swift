//
//  WeatherViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/22/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var weatherDegreeLabel: UILabel! 
    
    @IBOutlet weak var weatheStatusLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weather: Weather?
    let weekdays = ["Ср", "Чт", "Пт", "Сб", "Вс"]
    let weathers = ["17", "18", "20", "17", "18"]
    
    var dates = [Date]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Погода"
        self.navigationController?.navigationBar.topItem?.title = ""
        ServerManager.shared.getWeather(setWeather(weather:)) { (error) in
        }
    }
    
    func setWeather(weather: Weather) {
        self.weather = weather
        updateValues()
        print("Done")
    }
}

//MARK: UICollectionViewDataSourse, UICollectionViewDelegate methods

extension WeatherViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.weekdayLabel.text = weekdays[indexPath.row]
        cell.weatherDegreeLabel.text = weathers[indexPath.row] + "°"
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
    }

}
