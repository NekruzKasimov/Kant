//
//  BeetPoint.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 11/13/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct BeetPoint{
    var id: Int
    var name: String
    
    init (json: JSON){
        id = json["id"].intValue
        name = json["name"].stringValue
    }
}


class BeetPoints: NSObject {
    var array: Array = Array<BeetPoint>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = BeetPoint(json:json)
            array.append(tempObject)
        }
    }
}
