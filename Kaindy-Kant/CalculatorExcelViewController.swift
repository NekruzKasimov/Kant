//
//  CalculatorExcelViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/24/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import KRProgressHUD

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
    
    var expenses: Expenses?
    
    var totalIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        configureTableView()
        KRProgressHUD.show()
        self.title = "Расчитать бюджет"
        ServerManager.shared.getExpenses(setExpenses) { (error) in
            KRProgressHUD.dismiss()
            self.showErrorAlert(message: error)
        }
    }
    
    func setExpenses(expenses: Expenses) {
        KRProgressHUD.dismiss()
        self.expenses = expenses
        CalculatorExcelLogicController.shared.updateTotalValues(expenses: self.expenses!)
        tableView.reloadData()
    }
}

//MARK: UITableViewDataSourse methods

extension CalculatorExcelViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ExcelSections.items.rawValue == section {
            if let count = expenses?.array.count {
                return count
            }
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let secType = ExcelSections(rawValue: indexPath.section)!
        switch secType {
        case .first:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstSectionTableViewCell") as! FirstSectionTableViewCell
            return cell
        case .items:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalculatorExcelTableViewCell") as! CalculatorExcelTableViewCell
            cell.setValues(expense: (expenses?.array[indexPath.row])!, counter: indexPath.row)
            cell.totalLabel.text = "\(CalculatorExcelLogicController.shared.total[indexPath.row])"
            return cell
        case .total:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExcelTotalTableViewCell") as! ExcelTotalTableViewCell
            self.totalIndexPath = indexPath
            cell.totalLabel.text = "\(CalculatorExcelLogicController.shared.totalValue)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let label = UILabel()
            label.text = "Расходы на механизацию и ручной труд"
            label.textAlignment = .center
            label.backgroundColor = UIColor.init(netHex: Colors.gray)
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
