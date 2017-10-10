//
//  Rossahar.swift
//  Kaindy-Kant
//
//  Created by ITLabAdmin on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Rossahar {
    var results: Results
    
    init(json: JSON) {
        results = Results(json: json["results"])
    }
    func getNewRossahar() -> [String: Any] {
        return ["results": results]
    }
}
class Rossahars: NSObject {
    override init() {}
    var array: Array = Array<Rossahar>()
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Rossahar(json:json)
            array.append(tempObject)
        }
    }
}
