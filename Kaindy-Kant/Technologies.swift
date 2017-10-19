//
//  Technologies.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/20/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Technology {
    var id: Int
    var name: String
    var text: String
    
    init (json: JSON){
        id = json["id"].intValue
        name = json["name"].stringValue
        text = json["text"].stringValue
    }
}


class Technologies: NSObject {
    var array: Array = Array<Technology>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Technology(json:json)
            array.append(tempObject)
        }
    }
}

