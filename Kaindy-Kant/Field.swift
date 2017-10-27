//
//  Expenses.swift
//  Kaindy-Kant
//
//  Created by Niko on 9/26/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON
struct Coordinate {
    var latitude: String
    var longitude: String
    var number: Int
    init(json: JSON) {
        latitude = json["latitude"].stringValue
        longitude = json["longitude"].stringValue
        number = json["number"].intValue
    }
}
struct Field {
    var field_id: String
    var hectares: Double
    var coordinates: Array = Array<Coordinate>()
    init(json: JSON) {
        field_id = json["field_id"].stringValue
        hectares = json["hectares"].doubleValue
        let jsonArr:[JSON] = json["fields"].arrayValue
        for json in jsonArr {
            let tempCoordinate = Coordinate(json:json)
            coordinates.append(tempCoordinate)
        }
    }
}
struct Year {
    var year: String
    var fields: Array = Array<Field>()
    init(json: JSON) {
        year = json["year"].stringValue
        let jsonArr:[JSON] = json["fields"].arrayValue
        for json in jsonArr {
            let tempField = Field(json:json)
            fields.append(tempField)
        }
    }
}

class Years: NSObject {
    var years: Array = Array<Year>()
    init(json: JSON) {
        let jsonArr:[JSON] = json["all_fields"].arrayValue
        for json in jsonArr {
            let tempYear = Year(json:json)
            years.append(tempYear)
        }
    }
}

