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
    }
}

//MARK: UITableViewDataSourse methods

extension BranchesViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BranchesMapTableViewCell") as! BranchesMapTableViewCell
        if loc.count > 0 {
            cell.setMapMarkers(loc: loc, titles: titles)
        }
        return cell
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

