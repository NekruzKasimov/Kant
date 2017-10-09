//
//  Weather_ViewController.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 10/5/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

class Weather_ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

  @IBOutlet weak var weatherCollectionView: UICollectionView!
    let days = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.weekdayLabel?.text = days[indexPath.row]
        cell.weatherDegreeLabel?.text = "24"
        cell.nightWeatherDegreeLabel?.text = "18"
        //cell.weatherDegreeLabel?.text =
        return cell
    }
    
}
