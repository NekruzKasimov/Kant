//
//  Sugar.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 10/11/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Sugar {
    var name: String
    var price: String
    var percentage: String
    var date: String
    
    init ()
    {
        name = ""
        price = ""
        percentage = ""
        date = ""
    }
    init(json: JSON) {
        name = json["name"].stringValue
        price = json["price"].stringValue
        percentage = json["percentage"].stringValue
        date = json["date"].stringValue
    }
}

class Sugars: NSObject {
    override init() {}
    var array: Array = Array<Sugar>()
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Sugar(json:json)
            array.append(tempObject)
        }
    }
}
