//
//  Services.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/19/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Service {
    var id: Int
    var name: String
    var detailedServices: DetailedServices
    var logo: String?
    
    init (json: JSON){
        id = json["id"].intValue
        name = json["name"].stringValue
        detailedServices = DetailedServices(json: json["data"])
        logo = json["logo"].stringValue
    }
}


class Services: NSObject {
    var array: Array = Array<Service>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Service(json:json)
            array.append(tempObject)
        }
    }
}
