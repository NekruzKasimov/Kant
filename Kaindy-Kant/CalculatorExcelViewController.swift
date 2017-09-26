//
//  CalculatorExcelViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/24/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit

enum ExcelSections : Int {
    case first = 0
    case items = 1
    case total = 2
    
    func getItemsCount() -> Int {
        switch self {
        case .first:
            return 1
        case .items:
            return 1
        case .total:
            return 1
        }
    }
}

class CalculatorExcelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        configureTableView()
    }
    
}

//MARK: UITableViewDataSourse methods

extension CalculatorExcelViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExcelSections(rawValue: section)!.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let secType = ExcelSections(rawValue: indexPath.section)!
        let width = tableView.frame.width / 5
        switch secType {
        case .first:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstSectionTableViewCell") as! FirstSectionTableViewCell
            cell.setConstraints(width: width)
            return cell
        case .items:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalculatorExcelTableViewCell") as! CalculatorExcelTableViewCell
            cell.titleLabel.text = "text text text text text text text"
            cell.setConstraints(width: width)
            return cell
        case .total:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExcelTotalTableViewCell") as! ExcelTotalTableViewCell
            cell.setConstraints(width: width)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let label = UILabel()
            label.text = "Расходы на механизацию и ручной труд"
            label.textAlignment = .center
            label.backgroundColor = UIColor.init(netHex: Colors.orange)
            label.layer.borderWidth = 1
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold)
            return label
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return UIScreen.main.bounds.width < 375 ? 60 : 30
        }
        return 0
    }
}


//MARK: Helper functions

extension CalculatorExcelViewController {
    func configureTableView() {
        tableView.tableFooterView                   = UIView()
        tableView.separatorStyle                    = .none
        tableView.estimatedRowHeight                = 80
        tableView.rowHeight                         = UITableViewAutomaticDimension
    }
}
