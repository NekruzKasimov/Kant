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
    
    func setTotalValue(total: Int) {
        delegate?.updateTotalValue(total: total)
    }
}
