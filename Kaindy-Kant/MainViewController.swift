//
//  MainViewController.swift
//  Kaindy-Kant
//
//  Created by ZYFAR on 07.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

//enum tableViewSections : Int {
//    case firstSection = 0
//    case secondSection = 1
//    case thirdSection = 2
//}

class MainViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var mainMenuBtn: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        mainMenuBtn.target = revealViewController()
        mainMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
    }

}

//MARK UITableViewDataSourse methods
extension MainViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "FirstSectionTableViewCell") as! FirstSectionTableViewCell
        } else if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        }
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: Helper Functions

extension MainViewController {
    func configureTableView() {
        tableView.rowHeight             = 80
        tableView.estimatedRowHeight    = UITableViewAutomaticDimension
        tableView.tableFooterView       = UIView()
    }
}
