//
//  MainViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SVProgressHUD

enum MainVCSections : Int {
    case currency = 0
    case services = 1
    
    func getItemsCount() -> Int {
        switch self {
        case .currency:
            return 2
        case .services:
            return 4
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

    var services: Services?
    var weather: Weather?
    var currencies: [Currency]?
    var user: NewUser?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        mainMenuBtn.target = revealViewController()
        mainMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        ServerManager.shared.getWeather(setWeather, error: { (error) in
            SVProgressHUD.dismiss()
            self.showErrorAlert(message: error)
        })
        ServerManager.shared.getCurrecncies(setCurrencies, error: { (error) in
            SVProgressHUD.dismiss()
            self.showErrorAlert(message: error)
        })
        if DataManager.shared.getUserInformation() == nil {
            ServerManager.shared.getUser(setUserInfo, error: { (error) in
                SVProgressHUD.dismiss()
                self.showErrorAlert(message: error)
            })
        } else {
            self.user = NewUser()
        }
        
        if DataManager.shared.getServices() == nil {
            ServerManager.shared.getServices(setServices, error: { (error) in
                SVProgressHUD.dismiss()
                self.showErrorAlert(message: error)
            })
        } else {
            services = DataManager.shared.getServices()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = "Главная"
    }
    
    func setUserInfo(user: NewUser){
        //print(user.toDictionary())
        DataManager.shared.saveUserInformation(userDictionary: user.toDictionary() as! [String : String])
        self.user = user
    }
    
    func setServices(services: Services) {
        self.services = services
        DataManager.shared.setServices(Services: self.services!)
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
        if let _ = currencies, let _ = weather, let _ = user, let _ = services {
            SVProgressHUD.dismiss()
            return MainVCSections(rawValue: section)!.getItemsCount()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let secType = MainVCSections(rawValue: indexPath.section)!
        switch secType {
        case .currency:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionViewCell", for: indexPath) as! CurrencyCollectionViewCell
                if let c = currencies {
                    cell.setValues(currencies: c)
                }
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
                cell.weatherDegreeLabel.text = degree > 0 ? "+\(degree)°C" : "\(degree)°C"
                cell.weatherStatusLabel.text = status
                return cell
            }
        case .services:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for: indexPath) as! ServiceCollectionViewCell
            
            cell.titleLabel.text = Constants.MainPage.services[indexPath.row][0]
            cell.titleLabel.font = UIFont.systemFont(ofSize: 20)
            
            cell.imageView.kf.setImage(with: URL(string: (services?.array[indexPath.row].logo)!))
            
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
            let width = collectionView.frame.width - 24
            size = CGSize(width: width, height: 150)
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
                let vc = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
                vc.weather = self.weather
                self.navigationController?.show(vc, sender: self)
            }
        case .services:
            if indexPath.row != 3 {
                let sb = UIStoryboard(name: "DetailedService", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "DetailedSceneViewController") as! DetailedSceneViewController
                vc.detailedServices = services?.array[indexPath.row].detailedServices
                vc.serviceTitle = services?.array[indexPath.row].name
                navigationController?.show(vc, sender: self)
            } else {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "TechnologiesListViewController") as! TechnologiesListViewController
                navigationController?.show(vc, sender: self)
            }
        }
    }
}

//MARK: Helper functions

extension MainViewController {
    
    func setWeather(weather: Weather){
        self.weather = weather
        setTodayWeather()
    }
    func setCurrencies(currencies: [Currency]) {
        self.currencies = currencies
        collectionView.reloadData()
    }
    
    func setTodayWeather() {
        for i in (weather?.list.array)! {
            let hour = Calendar.current.component(.hour, from: i.date)
            if hour == 15 {
                degree = Int(i.main.temp)
                if let item = Constants.Weather.weatherStatuses[i.weatherStatuses.array[0].main] {
                    self.status = item
                }
                break
            }
        }
        collectionView.reloadData()
    }
}
