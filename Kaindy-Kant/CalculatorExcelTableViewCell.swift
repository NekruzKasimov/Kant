//
//  CalculatorExcelTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/24/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class CalculatorExcelTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var counterLabel: UILabel! {
        didSet {
            counterLabel.layer.borderWidth = 1
        }
    }
    
    var valueChangeHandler: ((Int, Int)->())?
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var priceTF: UITextField! {
        didSet {
            priceTF.keyboardType = .decimalPad
            priceTF.delegate = self
            priceTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var amountTF: UITextField! {
        didSet {
            amountTF.keyboardType = .decimalPad
            amountTF.delegate = self
            amountTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var totalLabel: UILabel! {
        didSet {
            totalLabel.layer.borderWidth = 1
        }
    }
    
    func setValues(expenses: Expenses, counter: Int) {
        self.priceTF.placeholder = "\(expenses.price)"
        self.amountTF.placeholder = "\(expenses.amount)"
        self.titleLabel.text = expenses.name
        self.counterLabel.text = "\(counter + 1)"
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
        valueChangeHandler?(price * amount, Int(self.counterLabel.text!)!)
        self.totalLabel.text = "\(price * amount)"
        reloadInputViews()
    }
}
