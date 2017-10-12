//
//  Currency.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 10/12/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Rates {
    var buy_rate: String
    var date_start: String
    var sell_rate: String
    init(json: JSON) {
        buy_rate = json["buy_rate"].stringValue
        date_start = json["date_start"].stringValue
        sell_rate = json["sell_rate"].stringValue

    }
}

struct Currency {
    var title: String
    var title_alias: String
    var id: String
    var rates: Rates
    
    init(json: JSON) {
        title = json["title"].stringValue
        title_alias = json["title_alias"].stringValue
        id = json["id"].stringValue
        rates = Rates(json: json["rates"])
    }
}
class Currencies: NSObject {
    override init() {}
    var array: Array = Array<Currency>()
    init(json: JSON) {
        var data = json["data"]
        //var currenc
        for i in 2...4 {
            array.append(Currency(json: data["\(i)"]))
        }
    }
}
