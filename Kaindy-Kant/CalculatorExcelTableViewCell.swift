//
//  CalculatorExcelTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/24/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class CalculatorExcelTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var valueChangeHandler: ((Int, Int)->())?

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceTF: UITextField! {
        didSet {
            priceTF.keyboardType = .numberPad
            priceTF.delegate = self
            priceTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var amountTF: UITextField! {
        didSet {
            amountTF.keyboardType = .numberPad
            amountTF.delegate = self
            amountTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var totalLabel: UILabel!
    
    func setValues(expense: Expense, counter: Int) {
        self.priceTF.placeholder = "\(CalculatorExcelLogicController.shared.prices[counter])"
        self.amountTF.placeholder = "\(CalculatorExcelLogicController.shared.amounts[counter])"
        self.titleLabel.text = "\(counter + 1).\n\(expense.name)"
        self.tag = counter
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueChangeHandler = CalculatorExcelLogicController.shared.updateValues(total:counter:)
    }
    
    func setAmountAndPrice(amount: Int, price: Int) {
        priceTF.text = "\(price)"
        amountTF.text = "\(amount)"
    }
}

extension CalculatorExcelTableViewCell {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textFieldDidChange()
        return true
    }
    
    func textFieldDidChange() {
        let price = priceTF.text == "" ? Int(priceTF.placeholder!)! : Int(priceTF.text!)!
        let amount = amountTF.text == "" ? Int(amountTF.placeholder!)! : Int(amountTF.text!)!
        DataManager.shared.update(index: self.tag, price: price, amount: amount)
        CalculatorExcelLogicController.shared.amounts[self.tag] = amount
        CalculatorExcelLogicController.shared.prices[self.tag] = price
        valueChangeHandler?(price * amount, self.tag)
        self.totalLabel.text = "\(price * amount)"
        reloadInputViews()
    }
}
