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
    var id: Int
    var price: Int
    var name: String
    var amount: Int
    
    init() {
        self.id = 0
        self.price = 0
        self.name = ""
        self.amount = 0
    }
    
    init(json: JSON) {
        id = json["id"].intValue
        price = json["price"].intValue
        name = json["name"].stringValue
        amount = json["amount"].intValue
    }
    func to_dictionary() -> [String: Any]{
        return ["id": id, "price": price, "amount": amount]
    }
}

class Expenses: NSObject {
    var array: Array = Array<Expense>()
    override init() {
    }
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Expense(json:json)
            array.append(tempObject)
        }
    }
    func getArrayDictionary() -> [[String: Any]]{
        var expenses = [[String: Any]]()
        for expense in self.array {
            expenses.append(expense.to_dictionary())
        }
        return expenses
    }
}
