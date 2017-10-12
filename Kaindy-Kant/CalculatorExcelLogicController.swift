//
//  CalculatorExcelLogicController.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/27/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

protocol UpdateTotalValueDelegate: class {
    func updateTotalValue(total: Int)
}

class CalculatorExcelLogicController {
    
    class var shared: CalculatorExcelLogicController {
        struct Static {
            static let instance = CalculatorExcelLogicController()
        }
        return Static.instance
    }
    
    var delegate: UpdateTotalValueDelegate?
        
    var totalValue = 0
    
    var total: [Int] = []
    
    func setTotalValue(total: Int) {
        delegate?.updateTotalValue(total: total)
    }
    
    func updateTotalValues(expenses: Expenses) {
        for item in expenses.array {
            let total = item.amount * item.price
            self.total.append(total)
            totalValue += total
        }
    }
    
    func updateValues(total: Int, counter: Int) {
        let value = self.total[counter - 1]
        totalValue -= value
        totalValue += total
        self.total[counter - 1] = total
        setTotalValue(total: totalValue)
    }
}
