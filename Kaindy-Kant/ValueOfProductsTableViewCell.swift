//
//  ValueOfProductsTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 11/27/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class ValueOfProductsTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    let lang = DataManager.shared.getLanguage()
    
    @IBOutlet weak var valueLabel: UILabel! {
        didSet {
            valueLabel.text = "product_price".localized(lang: lang)
        }
    }
    
    @IBOutlet weak var valueTextField: UITextField! {
        didSet {
            valueTextField.textColor = UIColor.init(netHex: Colors.placeholderColor)
            valueTextField.text = "3400"
            valueTextField.placeholder = "3400"
            valueTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            valueTextField.keyboardType = .numberPad
            valueTextField.delegate = self
        }
    }
}


extension ValueOfProductsTableViewCell {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.textColor == UIColor.init(netHex: Colors.placeholderColor) {
            textField.text = ""
        }
        return true
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        textField.textColor = UIColor.init(netHex: Colors.purple)
        let value = valueTextField.text == "" ? Int(valueTextField.placeholder!)! : Int(valueTextField.text!)!
        CalculatorExcelLogicController.shared.setValueOfProduct(int: value)
    }
}
