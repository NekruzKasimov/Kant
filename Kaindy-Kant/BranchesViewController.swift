//
//  BranchesViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

class BranchesViewController: ViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapSegment: UISegmentedControl! {
        didSet {
            mapSegment.setTitle("addresses".localized(lang: self.lang), forSegmentAt: 1)
        }
    }
    
    @IBAction func showMapOrAddresses(_ sender: Any) {
        tableView.reloadData()
    }
    
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
        if mapSegment.selectedSegmentIndex == 1 {
            return titles.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mapSegment.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BranchesMapTableViewCell") as! BranchesMapTableViewCell
            if loc.count > 0 {
                cell.setMapMarkers(loc: loc, titles: titles)
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "BranchesTableViewCell") as!
        BranchesTableViewCell
        cell.titleLabel.text = titles[indexPath.row]
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

