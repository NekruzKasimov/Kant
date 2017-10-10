//
//  BranchesViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

class BranchesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var titles: [String] = []
    var loc: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}

//MARK: UITableViewDataSourse methods

extension BranchesViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return titles.count
        } else if section == 1 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BranchesTableViewCell") as! BranchesTableViewCell
            cell.titleLabel.text = titles[indexPath.row]
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BranchesMapTableViewCell") as! BranchesMapTableViewCell
            cell.setMapMarkers(loc: loc, titles: titles)
            return cell
        }
        return UITableViewCell()
    }
}

extension BranchesViewController {
    func configureTableView() {
        tableView.estimatedRowHeight            = 80
        tableView.rowHeight                     = UITableViewAutomaticDimension
        tableView.tableFooterView               = UIView()
    }
}



//MARK: SJSegmentViewController

extension BranchesViewController: SJSegmentedViewControllerViewSource {

    func viewForSegmentControllerToObserveContentOffsetChange() -> UIView {
        return tableView
    }
}

