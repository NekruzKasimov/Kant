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
    var coordinates: Coordinates
    var average_harvest: Double
    var point_id: Int
    func getFieldToAddDictionary() -> [String: Any] {
        var coordinatesToAdd = [[String: Any]]()
        for coordinate in coordinates.array {
            coordinatesToAdd.append(coordinate.coordinateToDictionary())
        }
        let dic = ["year": year, "field_id": field_id, "hectares": hectares,
                   "coordinates": coordinatesToAdd, "average_harvest": average_harvest, "point_id": point_id] as [String : Any]
        return dic
    }
}


