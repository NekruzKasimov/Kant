//
//  Expenses.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/26/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

class Expenses {
    var price: Int
    var name: String
    var amount: Int
    
    init() {
        self.price = 0
        self.name = ""
        self.amount = 0
    }
    
    init(price: Int, name: String, amount: Int) {
        self.price = price
        self.name = name
        self.amount = amount
    }
}
