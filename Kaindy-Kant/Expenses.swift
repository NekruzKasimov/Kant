//
//  Expenses.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/26/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Expenses {
    var price: Int
    var name: String
    //var amount: Int
    
    init() {
        self.price = 0
        self.name = ""
       // self.amount = 0
    }
    
    init(json: JSON) {
        price = json["price"].intValue
        name = json["name"].stringValue
       // amount = json["amount"].intValue
    }
}
class Expenseses: NSObject {
    override init() {}
    var array: Array = Array<Expenses>()
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Expenses(json:json)
            array.append(tempObject)
        }
    }
}
