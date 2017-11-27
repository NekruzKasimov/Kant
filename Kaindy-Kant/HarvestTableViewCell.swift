//
//  HarvestTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 11/27/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class HarvestTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var yieldLabel: UILabel!
    
    @IBOutlet weak var yieldTF: UITextField!{
        didSet {
            yieldTF.textColor = UIColor.init(netHex: Colors.placeholderColor)
            yieldTF.text = "0.0"
            yieldTF.placeholder = "0.0"
            yieldTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            yieldTF.keyboardType = .numberPad
            yieldTF.delegate = self
        }
    }
    
    @IBOutlet weak var areaTF: UITextField!{
        didSet {
            areaTF.textColor = UIColor.init(netHex: Colors.placeholderColor)
            areaTF.text = "0.0"
            areaTF.placeholder = "0.0"
            areaTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            areaTF.keyboardType = .numberPad
            areaTF.delegate = self
        }
    }
    
    @IBOutlet weak var resultLabel: UILabel!{
        didSet {
            resultLabel.text = "0.0"
        }
    }
    
    func setYieldAndArea(yield: Double, area: Double){
        self.yieldTF.text = "\(yield)"
        self.yieldTF.isUserInteractionEnabled = false
        self.yieldTF.textColor = .black
        self.areaTF.text = "\(area)"
        self.areaTF.isUserInteractionEnabled = false
        self.areaTF.textColor = .black
        resultLabel.text = "\(yield * area)"
        CalculatorExcelLogicController.shared.yield = yield
        CalculatorExcelLogicController.shared.area = area
        CalculatorExcelLogicController.shared.harvest = yield * area
    }
}


extension HarvestTableViewCell {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.textColor == UIColor.init(netHex: Colors.placeholderColor) {
            textField.text = ""
        }
        return true
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        textField.textColor = .black
        let yield = yieldTF.text == "" ? Double(yieldTF.placeholder!)! : Double(yieldTF.text!)!
        let area = areaTF.text == "" ? Double(areaTF.placeholder!)! : Double(areaTF.text!)!
        resultLabel.text = "\(yield * area)"
        CalculatorExcelLogicController.shared.harvest = Double(yield * area)
        CalculatorExcelLogicController.shared.setYieldAndArea(yield: Double(yield), area: area)
    }
}
