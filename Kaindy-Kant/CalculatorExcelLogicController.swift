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


protocol ProfitDelegate: class {
    func updateProfitData()
}

protocol IncomeDelegate: class {
    func updateIncomeData()
}

class CalculatorExcelLogicController {
    
    var amounts = [Int]()
    var prices = [Int]()
    var valueOfProduct = 3400
    var income = 0
    var totalValue = 0
    var harvest: Double = 0
    var yield: Double = 0
    var area: Double = 0
    
    class var shared: CalculatorExcelLogicController {
        struct Static {
            static let instance = CalculatorExcelLogicController()
        }
        return Static.instance
    }
    
    var delegate: UpdateTotalValueDelegate?
    var profitDelegate: ProfitDelegate?
    var incomeDelegate: IncomeDelegate?
    
    var total: [Int] = []
    
    func setValueOfProduct(int: Int) {
        valueOfProduct = int
        incomeDelegate?.updateIncomeData()
    }
    
    func setYieldAndArea(yield: Double, area: Double){
        self.yield = yield
        self.area = area
        incomeDelegate?.updateIncomeData()
        profitDelegate?.updateProfitData()
    }
    
    func setTotalValue(total: Int) {
        delegate?.updateTotalValue(total: total)
        profitDelegate?.updateProfitData()
    }
    
    func updateTotalValues(expenses: Expenses) {
        for item in expenses.array {
            let total = item.amount * item.price
            self.total.append(total)
            totalValue += total
        }
    }
    
    func updateValues(total: Int, counter: Int) {
        let value = self.total[counter]
        totalValue -= value
        totalValue += total
        self.total[counter] = total
        setTotalValue(total: totalValue)
    }
}
