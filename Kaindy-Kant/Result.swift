//
//  Result.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Result {
    var link: String
    var data: String
    var name: String
    var description: String
    
    init(json: JSON) {
        link = json["link"].stringValue
        data = json["data"].stringValue
        name = json["name"].stringValue
        description = json["description"].stringValue
    }
}
class Results: NSObject {
    override init() {}
    var array: Array = Array<Result>()
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Result(json:json)
            array.append(tempObject)
        }
    }
}
