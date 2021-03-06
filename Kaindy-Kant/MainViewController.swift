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
    
    func getItemsCount() -> Int {
        switch self {
        case .currency:
            return 2
        }
    }
}

class MainViewController: ViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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
    
    var servicesCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        self.title = "main_menu".localized(lang: self.lang)
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        mainMenuBtn.target = revealViewController()
        mainMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        downloadData()
    }
    
    func downloadData() {
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
                self.unauthorizedError(message: error)
                
            })
        } else {
            self.user = NewUser()
        }
        ServerManager.shared.getServices(setServices) { (message) in
//            self.unauthorizedError(message: message)
        }
    }
    
    func unauthorizedError(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        //Add
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            let sb = UIStoryboard(name: "Login", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "LoginViewController")
            self.navigationController?.present(vc, animated: false, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func setUserInfo(user: NewUser){
        DataManager.shared.saveUserInformation(userDictionary: user.toDictionary() as! [String : String])
        self.user = user
        collectionView.reloadData()
    }
    
    func setServices(services: Services) {
        self.services = services
        DataManager.shared.setServices(Services: self.services!)
        collectionView.reloadData()
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
        if let _ = currencies, let _ = weather, let _ = services {
            if let _ = user {
                SVProgressHUD.dismiss()
                if section == 0 {
                    return 2
                } else {
                    if (services?.array.count)! > 0 {
                        return 3
                    }
                    else {
                        return 2
                    }
                }
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionViewCell", for: indexPath) as! CurrencyCollectionViewCell
                if let c = currencies {
                    cell.setValues(currencies: c, language: self.lang)
                }
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
                cell.weatherDegreeLabel.text = degree > 0 ? "+\(degree)°C" : "\(degree)°C"
                cell.weatherStatusLabel.text = status
                cell.weatherLabel.text = "weather".localized(lang: self.lang)!
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for: indexPath) as! ServiceCollectionViewCell
            var title = ""
            if indexPath.row == 0 {
                title = (Constants.MainPage.myFields?.localized(lang: self.lang)!)!
                cell.imageView.image = UIImage(named: "beet")
            }
            else if indexPath.row == 1 {
                title = (Constants.MainPage.technology?.localized(lang: self.lang)!)!
                cell.imageView.image = UIImage(named: "technology")
            } else {
                title = (services?.array[indexPath.row - 2].name)!
                cell.imageView.kf.setImage(with: URL(string: (services?.array[indexPath.row - 2].logo)!))
            }
            cell.titleLabel.text = title
            cell.titleLabel.font = UIFont.systemFont(ofSize: 20)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        let height = CGFloat(200)
        if indexPath.section == 0 {
            var width = collectionView.frame.width - 30
            width = width / 2
            size = CGSize(width: width, height: height)
        } else {
            let width = collectionView.frame.width - 24
            size = CGSize(width: width, height: 120)
        }
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        } else if section == 1 {
            return UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if indexPath.item == 0 {
                return
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
                vc.weather = self.weather
                self.navigationController?.show(vc, sender: self)
            }
        } else {
            if indexPath.row == 0 {
                let sb = UIStoryboard(name: "Profile", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "FieldViewController") as! FieldViewController
                vc.isFromMainPage = true
                self.navigationController?.show(vc, sender: self)
            }
            else if indexPath.row == 1 {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "TechnologiesListViewController") as! TechnologiesListViewController
                navigationController?.show(vc, sender: self)
                
            } else {
                let sb = UIStoryboard(name: "DetailedService", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "DetailedSceneViewController") as! DetailedSceneViewController
                vc.detailedServices = services?.array[indexPath.row - 2].detailedServices
                vc.serviceTitle = services?.array[indexPath.row - 2].name
                navigationController?.show(vc, sender: self)
            }
        }
    }
}

//MARK: Helper functions

extension MainViewController {
    
    func setWeather(weather: Weather){
        self.weather = weather
        var degreeToday = ""
        var statusToday = ""
       // let currentDate = Date()

        //statusToday = Constants.Weather.weatherStatuses[(self.weather?.today.array[0].type)!]!
        degreeToday = (self.weather?.today.array[0].temp)!
//        for item in (self.weather?.today.array)! {
//            switch currentDate.compare(item.exact_time) {
//            case .orderedAscending:
//                statusToday = Constants.Weather.weatherStatuses[item.type]!
//                degreeToday = item.temp
//            default:
//                break
//            }
//        }
        self.degree = Int(degreeToday)!
        self.status = statusToday
        guard let status = Constants.Weather.weatherStatuses[(self.weather?.today.array[0].type)!] else {
            collectionView.reloadData()
            return
        }
        statusToday = status
        collectionView.reloadData()
    }
    func setCurrencies(currencies: [Currency]) {
        self.currencies = currencies
        collectionView.reloadData()
    }
    

}
