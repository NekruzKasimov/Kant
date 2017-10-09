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

    @IBOutlet weak var mySCOutlet: UISegmentedControl!
    //var newRossahar: Rossahar?
    let newRossahar = ServerManager.shared
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
            newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    
    }
   
    @IBAction func mySegmentedControllAction(_ sender: Any) {
        switch mySCOutlet.selectedSegmentIndex {
        case 0:

        case 1:
       //     afasdfa
        default:
            break;  <#code#>
        }
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsSections(rawValue: section)!.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch NewsSections(rawValue: indexPath.section)! {
        case .sugar:
            cell = tableView.dequeueReusableCell(withIdentifier: "SugarTableViewCell")!
            break
        case .news:
            cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 204
    }
}
