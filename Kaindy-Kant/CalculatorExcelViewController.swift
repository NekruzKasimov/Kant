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
    var isFromMapViewController = false
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
            if isFromMapViewController {
                let backImage = UIBarButtonItem(image: UIImage.init(named: "back-5"), style: .plain, target: self, action: #selector(backTapped))
                self.navigationItem.leftBarButtonItem = backImage
            }
        }
    }
    func backTapped() {
        if let viewControllers = self.navigationController?.viewControllers {
            self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        }
//        let sb = UIStoryboard(name: "Profile", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "FieldViewController") as! FieldViewController
//        self.navigationController?.popToViewController(vc, animated: false)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        CalculatorExcelLogicController.shared.prices.removeAll()
        CalculatorExcelLogicController.shared.amounts.removeAll()
        CalculatorExcelLogicController.shared.total.removeAll()
        CalculatorExcelLogicController.shared.totalValue = 0
    }
    
    func setExpenses(expenses: Expenses) {
        SVProgressHUD.dismiss()
        DataManager.shared.setExpenses(expenses: expenses)
        self.expenses = expenses
        CalculatorExcelLogicController.shared.updateTotalValues(expenses: self.expenses!)
        for item in expenses.array {
            CalculatorExcelLogicController.shared.amounts.append(item.amount)
            CalculatorExcelLogicController.shared.prices.append(item.price)
        }
        tableView.reloadData()
    }
}

//MARK: UITableViewDataSourse methods

extension CalculatorExcelViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if fieldId == -1 {
            return 3
        }
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
            let shared = CalculatorExcelLogicController.shared
            cell.setAmountAndPrice(amount: shared.amounts[indexPath.row], price: shared.prices[indexPath.row])
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
        SVProgressHUD.show()
        ServerManager.shared.updateExpenses(parameters: ["data": DataManager.shared.getExpenses()], expensesUpdated, error: showErrorAlert)
        print("save expenses")
    }
    
    func expensesUpdated(message: String){
        print(message)
        SVProgressHUD.dismiss()
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FieldViewController") as! FieldViewController
        self.navigationController?.show(vc, sender: self)
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
