//
//  Jon.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 10/11/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Jom {
    var name: String
    var price: String
    var percentage: String
    
    init ()
    {
        name = ""
        price = ""
        percentage = ""
    }
    
    init(json: JSON) {
        percentage = json["percentage"].stringValue
        price = json["price"].stringValue
        name = json["name"].stringValue
    }
}

class Joms: NSObject {
    override init() {}
    var array: Array = Array<Jom>()
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Jom(json:json)
            array.append(tempObject)
        }
    }
}
