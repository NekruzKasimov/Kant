//
//  MainViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

enum MainVCSections : Int {
    case first = 0
    case currency = 1
    case news = 2
    
    func getItemsCount() -> Int {
        switch self {
        case .first:
            return 3
        case .currency:
            return 2
        case .news:
            return 5
        }
    }
}

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //
    @IBOutlet weak var mainMenuBtn: UIBarButtonItem!
    //
    //    @IBOutlet weak var tableView: UITableView!
    //
    @IBOutlet weak var collectionView: UICollectionView!
    
    let firstRowTitles = ["Банки", "Технологии", "Поставщики"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        mainMenuBtn.target = revealViewController()
        mainMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
    
        
        //automaticallyAdjustsScrollViewInsets
        
//        configureCollectionView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainVCSections(rawValue: section)!.getItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let secType = MainVCSections(rawValue: indexPath.section)!
        switch secType {
        case .first:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstRowCollectionViewCell", for: indexPath) as! FirstRowCollectionViewCell
            cell.titleLabel.text = firstRowTitles[indexPath.row]
            return cell
        case .currency:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionViewCell", for: indexPath) as! CurrencyCollectionViewCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
                return cell
            }
        case .news:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let secType = MainVCSections(rawValue: indexPath.section)!
        var size = CGSize()
        var height = CGFloat(200)
        switch secType {
        case .first:
            height = 60
            let width = (collectionView.frame.width - 40) / 3
            size = CGSize(width: width, height: height)
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
        case .news:
            let width = collectionView.frame.width - 20
            size = CGSize(width: width, height: height)
        }
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var left = CGFloat(0)
        var right = CGFloat(0)
        if section == MainVCSections.first.rawValue  {
            right = 10
            left = 10
        } else if section == MainVCSections.currency.rawValue {
           left = 10
        }
        return UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secType = MainVCSections(rawValue: indexPath.section)!
        
        switch secType {
        case .first:
            break
        case .currency:
            if indexPath.item == 0 {
                break
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
                self.navigationController?.show(vc, sender: self)
            }
        case .news:
            break
        }
    }
    
    func configureCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
//        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        self.collectionView.collectionViewLayout = layout
    }
}

