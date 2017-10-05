//
//  MainViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

enum MainVCSections : Int {
    case currency = 0
    case services = 1
    
    func getItemsCount() -> Int {
        switch self {
        case .currency:
            return 2
        case .services:
            return 3
        }
    }
}

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var mainMenuBtn: UIBarButtonItem!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(ServiceCollectionViewCell.self, forCellWithReuseIdentifier: "ServiceCollectionViewCell")
            collectionView.register(UINib(nibName: "ServiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCollectionViewCell")
        }
    }

    var services = [["Финансовые учреждения", "bank"], ["Консультации", "consultation"], ["Лаборатории", "laboratory"]]
    var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        mainMenuBtn.target = revealViewController()
        mainMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ServerManager.shared.getWeather(setWeather) { (error) in
        }
    }
    
    var degree = 0
    var status = ""
}

//MARK: UICollectionViewDataSourse, Delegate, FlowDelegate functions

extension MainViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainVCSections(rawValue: section)!.getItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let secType = MainVCSections(rawValue: indexPath.section)!
        switch secType {
        case .currency:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionViewCell", for: indexPath) as! CurrencyCollectionViewCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
                cell.weatherDegreeLabel.text = degree > 0 ? "+\(degree)°C" : "\(degree)°C"
                cell.weatherStatusLabel.text = status
                return cell
            }
        case .services:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for: indexPath) as! ServiceCollectionViewCell
            
            cell.titleLabel.text = services[indexPath.row][0]
            cell.imageView.image = UIImage(named: services[indexPath.row][1])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let secType = MainVCSections(rawValue: indexPath.section)!
        var size = CGSize()
        let height = CGFloat(200)
        switch secType {
         case .currency:
            if indexPath.item == 0 {
                var width = collectionView.frame.width - 30
                width = width / 5 * 3
                size = CGSize(width: width, height: height)
            } else {
                var width = collectionView.frame.width - 30
                width = width / 5 * 2
                size = CGSize(width: width, height: height)
            }
        case .services:
            var width = collectionView.frame.width - 42
            width = width / 2
            size = CGSize(width: width, height: height)
        }
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var left = CGFloat(0)
        var right = CGFloat(0)
        if section == MainVCSections.services.rawValue  {
            right = 14
            left = 14
        } else if section == MainVCSections.currency.rawValue {
            left = 10
        }
        return UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secType = MainVCSections(rawValue: indexPath.section)!
        
        switch secType {
        case .currency:
            if indexPath.item == 0 {
                break
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Weather_ViewController") as! Weather_ViewController
//                vc.weather = self.weather
                self.navigationController?.show(vc, sender: self)
            }
        case .services:
            break
        }
    }
}

//MARK: Helper functions

extension MainViewController {
    
    func setWeather(weather: Weather){
        self.weather = weather
        setTodayWeather()
    }
    
    func setTodayWeather() {
        for i in (weather?.list.array)! {
            let hour = Calendar.current.component(.hour, from: i.date)
            if hour == 12 {
                degree = Int(i.main.temp)
                status = i.weatherStatuses.array[0].main
                print(i.weatherStatuses.array[0].main)
                break
            }
        }
        collectionView.reloadData()
    }
}
