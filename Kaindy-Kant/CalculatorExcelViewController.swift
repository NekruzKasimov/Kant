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
    case valueOfProducts = 3
    case harvest = 4
    case income = 5
    case profit = 6
    case save = 7
    
    func getItemsCount() -> Int {
        switch self {
        case .first:
            return 1
        case .items:
            return 1
        case .total:
            return 1
        case .valueOfProducts:
            return 1
        case .harvest:
            return 1
        case .income:
            return 1
        case .profit:
            return 1
        case .save:
            return 1
        }
    }
}

class CalculatorExcelViewController: ViewController, UITableViewDataSource, UITableViewDelegate, SaveButtonDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var expenses: Expenses?
    var fieldId = -1
    var isFromMapViewController = false
    var totalIndexPath: IndexPath?
    
    var yield: Double?
    var area: Double?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MenuViewController.hideKeyboardDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        SVProgressHUD.show()
        self.title = "budget".localized(lang: self.lang)!
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
        CalculatorExcelLogicController.shared.valueOfProduct = 3400
        CalculatorExcelLogicController.shared.income = 0
        CalculatorExcelLogicController.shared.totalValue = 0
        CalculatorExcelLogicController.shared.harvest = 0.0
        CalculatorExcelLogicController.shared.yield = 0.0
        CalculatorExcelLogicController.shared.area = 0
        tableView.reloadData()
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
            return 7
        }
        return 8
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
        case .valueOfProducts:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ValueOfProductsTableViewCell") as! ValueOfProductsTableViewCell
            return cell
        case .harvest:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HarvestTableViewCell") as! HarvestTableViewCell
            if fieldId != -1 {
                cell.setYieldAndArea(yield: yield!, area: area!)
            }
            return cell
        case .income:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeTableViewCell") as! IncomeTableViewCell
            let shared = CalculatorExcelLogicController.shared
            cell.resultLabel.text = "\(shared.harvest) * \(shared.valueOfProduct) = \(shared.harvest * Double(shared.valueOfProduct))"
            CalculatorExcelLogicController.shared.income = Int(shared.harvest * Double(shared.valueOfProduct))
            return cell
        case .profit:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfitTableViewCell") as! ProfitTableViewCell
            let shared = CalculatorExcelLogicController.shared
            cell.resultLabel.text = "\(shared.income) - \(shared.totalValue) = \(shared.income - shared.totalValue)"
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
        backTapped()
    }
}

//MARK: Helper functions

extension CalculatorExcelViewController: HideKeyboard {
    func stopEditing(){
        self.view.endEditing(true)
    }
    
    
    func configureTableView() {
        tableView.tableFooterView                   = UIView()
        tableView.estimatedRowHeight                = 80
        tableView.rowHeight                         = UITableViewAutomaticDimension
    }
}
