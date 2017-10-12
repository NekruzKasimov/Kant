//
//  Expenses.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/26/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Expense {
    var price: Int
    var name: String
    var amount: Int
    
    init() {
        self.price = 0
        self.name = ""
        self.amount = 0
    }
    
    init(json: JSON) {
        price = json["price"].intValue
        name = json["name"].stringValue
        amount = json["amount"].intValue
    }
}

class Expenses: NSObject {
    var array: Array = Array<Expense>()
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Expense(json:json)
            array.append(tempObject)
        }
    }
}
