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
    
    init(latitude: String, longitude: String, number: Int) {
        self.longitude = longitude
        self.latitude = latitude
        self.number = number
    }
    
    init(json: JSON) {
        latitude = json["latitude"].stringValue
        longitude = json["longitude"].stringValue
        number = json["number"].intValue
    }
    func coordinateToDictionary() -> [String: Any] {
        return ["latitude": latitude, "longitude": longitude, "number": number]
    }
}
class Coordinates: NSObject {
    var array: Array = Array<Coordinate>()
    override init() {
    }
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Coordinate(json:json)
            array.append(tempObject)
        }
    }
}
struct Field {
    var id: Int
    var field_id: String
    var hectares: Double
    var average_harvest: Double
    var coordinates: Coordinates
    var expenses: Expenses
    init(json: JSON) {
        id = json["id"].intValue
        field_id = json["field_id"].stringValue
        hectares = json["hectares"].doubleValue
        average_harvest = json["average_harvest"].doubleValue
        coordinates = Coordinates(json: json["coordinates"])
        expenses = Expenses(json: json["expenses"])
    }
}
struct Year {
    var year: String
    var fields: Array = Array<Field>()
    init(json: JSON) {
        year = json["year"].stringValue
        let jsonArr:[JSON] = json["data"].arrayValue
        for json in jsonArr {
            let tempField = Field(json:json)
            fields.append(tempField)
        }
    }
}

class Years: NSObject {
    var years: Array = Array<Year>()
    override init() {
    }
    init(json: JSON) {
        let jsonArr:[JSON] = json["all_fields"].arrayValue
        for json in jsonArr {
            let tempYear = Year(json:json)
            years.append(tempYear)
        }
    }
}

