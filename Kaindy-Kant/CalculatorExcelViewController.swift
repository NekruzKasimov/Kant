//
//  CalculatorExcelViewController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/24/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import UIKit
import SVProgressHUD

enum ExcelSections : Int {
    case first = 0
    case items = 1
    case total = 2
    case save = 3
    
    func getItemsCount() -> Int {
        switch self {
        case .first:
            return 1
        case .items:
            return 1
        case .total:
            return 1
        case .save:
            return 1
        }
    }
}

class CalculatorExcelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SaveButtonDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var expenses: Expenses?
    var fieldId = -1
    var totalIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        SVProgressHUD.show()
        self.title = "Рассчитать бюджет"
        if fieldId == -1 {
            setNavigationBar()
            ServerManager.shared.getExpenses(setExpenses) { (error) in
                SVProgressHUD.dismiss()
                self.showErrorAlert(message: error)
            }
        }
        else {
            ServerManager.shared.getFieldExpenses(field_id: fieldId, setExpenses) { (error) in
                SVProgressHUD.dismiss()
                self.showErrorAlert(message: error)
            }
        }
    }
    
    func setExpenses(expenses: Expenses) {
        SVProgressHUD.dismiss()
        self.expenses = expenses
        CalculatorExcelLogicController.shared.updateTotalValues(expenses: self.expenses!)
        tableView.reloadData()
    }
}

//MARK: UITableViewDataSourse methods

extension CalculatorExcelViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
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
        case .save:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SaveTableViewCell") as! SaveTableViewCell
            cell.cellDelegate = self
            return cell
        }
    }
    func didPressButton(_ tag: Int) {
        if fieldId == -1 {
            let sb = UIStoryboard(name: "Profile", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "FieldViewController") as! FieldViewController
            self.navigationController?.show(vc, sender: self)
        }
        print("save expenses")
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
