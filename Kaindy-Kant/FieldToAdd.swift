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
        var dic:[String: Any] = ["": 0]
        dic.updateValue(year as Int, forKey: "year")
        dic.updateValue(coordinatesToAdd as [[String: Any]], forKey: "coordinates")
        dic.updateValue(field_id as String, forKey: "field_id")
        dic.updateValue(hectares as Double, forKey: "hectares")

        return dic
    }
}


