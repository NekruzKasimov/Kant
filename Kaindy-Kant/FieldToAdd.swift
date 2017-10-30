//
//  Services.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/19/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FieldToAdd {
    var field_id: String
    var year: Int
    var hectares: Double
    var coordinates = [Coordinate]()
    
    func getFieldToAddDictionary() -> [String: Any] {
        var coordinatesToAdd = [[String: Any]]()
        for coordinate in coordinates {
            coordinatesToAdd.append(coordinate.coordinateToDictionary())
        }
        return ["year": year, "field_id": field_id, "hectares": hectares, "coordinates": coordinatesToAdd]
    }
}


