//
//  ContactsViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var contacts: Contacts!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
}

//MARK: UITableViewDataSourse methods

extension ContactsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (contacts?.array.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell") as! ContactsTableViewCell
        cell.titleLabel.text = contacts?.array[indexPath.row].type
        cell.dataLabel.text = contacts?.array[indexPath.row].data
        return cell
    }
}


//MARK: UITableViewDelegate methods

extension ContactsViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


//MARK: Helper functions

extension ContactsViewController {
    func configureTableView() {
        tableView.estimatedRowHeight            = 80
        tableView.rowHeight                     = UITableViewAutomaticDimension
        tableView.tableFooterView               = UIView()
    }
}

////MARK: SJSegmentViewController
//
//extension ContactsViewController: SJSegmentedViewControllerViewSource {
//    
//    func viewForSegmentControllerToObserveContentOffsetChange() -> UIView {
//        return tableView
//    }
//}

