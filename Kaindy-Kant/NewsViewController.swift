//
//  NewsViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 03.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

enum NewsSections: Int {
    case sugar = 0
    case news  = 1
    
    func getItemsCount() -> Int {
        switch self {
        case .sugar:
            return 1
        case .news:
            return 4
        }
    }
}

class NewsViewController: UIViewController {

    var newRossahar: Rossahar?
    @IBOutlet weak var mySCOutlet: UISegmentedControl!
    //var newRossahar: Rossahar?
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
            newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        ServerManager.shared.getNewsRossahar({ (succes) in
            self.setRossahar(rossahar: succes)
        }) { (error) in
            print(error)
        }
    }
    
    func setRossahar(rossahar: Rossahar) {
        self.newRossahar = rossahar
        newsTableView.reloadData()
    }
   
    @IBAction func mySegmentedControllAction(_ sender: Any) {
        switch mySCOutlet.selectedSegmentIndex {
        case 0:
            newsTableView.reloadData()
        case 1:
            newsTableView.reloadData()
        default:
            break
        }
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if let count = newRossahar?.results.array.count {
                return count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = UITableViewCell()
//
//        switch NewsSections(rawValue: indexPath.section)! {
//        case .sugar:
//            cell = tableView.dequeueReusableCell(withIdentifier: "SugarTableViewCell")!
//            break
//        case .news:
           let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
            cell.dataLabel.text = newRossahar?.results.array[indexPath.row].data
            cell.titleLabel.text = newRossahar?.results.array[indexPath.row].name
            cell.descriptionLabel.text = newRossahar?.results.array[indexPath.row].description
        
           // break
        //}

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 204
    }
}
